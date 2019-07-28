resource "aws_codedeploy_deployment_group" "groups" {
  depends_on = ["aws_codedeploy_app.backend", "aws_iam_role.codedeploy_for_lambda"]

  app_name               = "${aws_codedeploy_app.backend.name}"
  deployment_group_name  = "${element(local.deployment_group_names, count.index)}"
  service_role_arn       = "${aws_iam_role.codedeploy_for_lambda.arn}"
  deployment_config_name = "CodeDeployDefault.LambdaAllAtOnce"

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  count = "${length(local.deployment_group_names)}"
}

# -----------------------------------------------
# AWS CodeDeploy IAM Role
# -----------------------------------------------
resource "aws_iam_role" "codedeploy_for_lambda" {
  name               = "${local.project_name}-CodeDeployRoleForLambda"
  assume_role_policy = "${data.aws_iam_policy_document.codedeploy_principals.json}"
  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_iam_role_policy" "codedeploy_for_lambda" {
  name   = "${local.project_name}-CodeDeployBackendPolicy"
  role   = "${aws_iam_role.codedeploy_for_lambda.id}"
  policy = "${data.aws_iam_policy_document.codedeploy_for_lambda.json}"
}

data "aws_iam_policy_document" "codedeploy_for_lambda" {
  statement {
    effect = "Allow"

    actions = [
      "cloudwatch:DescribeAlarms",
      "lambda:UpdateAlias",
      "lambda:GetAlias",
      "sns:Publish"
    ]

    resources = ["*", ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]

    resources = ["arn:aws:s3:::*/CodeDeploy/*", ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]

    resources = ["arn:aws:s3:::*/CodeDeploy/*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:ExistingObjectTag/UseWithCodeDeploy"

      values = [true]
    }

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "lambda:InvokeFunction"
    ]

    resources = ["arn:aws:lambda:*:*:function:CodeDeployHook_*"]
  }
}

