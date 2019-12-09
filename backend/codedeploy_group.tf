resource "aws_codedeploy_deployment_group" "groups" {
  depends_on = [
    aws_codedeploy_app.backend,
    aws_iam_role.codedeploy_for_lambda,
  ]

  app_name               = aws_codedeploy_app.backend.name
  deployment_group_name  = "BlueGreenGroup"
  service_role_arn       = aws_iam_role.codedeploy_for_lambda.arn
  deployment_config_name = "CodeDeployDefault.LambdaAllAtOnce"

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
}

# -----------------------------------------------
# AWS CodeDeploy IAM Role
# -----------------------------------------------
resource "aws_iam_role" "codedeploy_for_lambda" {
  name               = "${local.project_name_uc}_CodeDeployRoleForLambda"
  assume_role_policy = file("iam/codedeploy_principals.json")
  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_iam_role_policy" "codedeploy_for_lambda" {
  name   = "${local.project_name}-CodeDeployBackendPolicy"
  role   = aws_iam_role.codedeploy_for_lambda.id
  policy = file("iam/codedeploy_policy_lambda.json")
}

