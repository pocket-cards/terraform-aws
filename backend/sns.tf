# ---------------------------------------------------------------------------------------------
# Amazon SNS Topic
# ---------------------------------------------------------------------------------------------
resource "aws_sns_topic" "notify" {
  name         = "${local.project_name_uc}_BuildNotify"
  display_name = "${local.project_name_uc}_BuildNotify"
}

# ---------------------------------------------------------------------------------------------
# Amazon SNS Topic Access Policy
# ---------------------------------------------------------------------------------------------
resource "aws_sns_topic_policy" "notify" {
  arn    = aws_sns_topic.notify.arn
  policy = templatefile("${path.module}/iam/sns_topic_policy_notify.tpl", {
    topic_name = "${local.project_name_uc}_BuildNotify", 
    account_id = local.account_id 
  })
}

# ---------------------------------------------------------------------------------------------
# Amazon SNS Topic Subscription
# ---------------------------------------------------------------------------------------------
resource "aws_sns_topic_subscription" "notify" {
  topic_arn = aws_sns_topic.notify.arn
  endpoint  = local.lambda.m002.arn
  protocol  = "lambda"
}
