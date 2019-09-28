# -----------------------------------------------
# SSM Parameter Store - Slack webhook url
# -----------------------------------------------
resource "aws_ssm_parameter" "slack_url" {
  name      = "/${local.project_name}/slack_url"
  type      = "SecureString"
  value     = "${var.slack_url}"
  overwrite = true
}
# -----------------------------------------------
# SSM Parameter Store - Translation api key
# -----------------------------------------------
resource "aws_ssm_parameter" "translation_api_key" {
  name      = "/${local.project_name}/translation_api_key"
  type      = "SecureString"
  value     = "${var.translation_api_key}"
  overwrite = true
}
# -----------------------------------------------
# SSM Parameter Store - IPA api key
# -----------------------------------------------
resource "aws_ssm_parameter" "ipa_api_key" {
  name      = "/${local.project_name}/ipa_api_key"
  type      = "SecureString"
  value     = "${var.ipa_api_key}"
  overwrite = true
}
# -----------------------------------------------
# SSM Parameter Store - Github token
# -----------------------------------------------
resource "aws_ssm_parameter" "github_token" {
  name      = "/${local.project_name}/github_token"
  type      = "SecureString"
  value     = "${var.github_token}"
  overwrite = true
}
