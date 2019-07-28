# -----------------------------------------------
# AWS Codebuild
# -----------------------------------------------
resource "aws_codebuild_project" "initialize" {
  depends_on = ["aws_iam_role.codebuild_role"]

  name          = "${local.project_name_uc}-Initialize"
  build_timeout = "5"
  service_role  = "${aws_iam_role.codebuild_role.arn}"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/nodejs:10.14.1"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec_${local.environment}.yml"
  }
}

# -----------------------------------------------
# AWS Codebuild Principals
# -----------------------------------------------
data "aws_iam_policy_document" "codebuild_principals" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

# -----------------------------------------------
# AWS Codebuild IAM Role
# -----------------------------------------------
resource "aws_iam_role" "codebuild_role" {
  name               = "${local.project_name_uc}_CodeBuild_InitializeRole"
  assume_role_policy = "${data.aws_iam_policy_document.codebuild_principals.json}"
  lifecycle {
    create_before_destroy = false
  }
}

# -----------------------------------------------
# AWS Codebuild IAM Policy
# -----------------------------------------------
resource "aws_iam_role_policy_attachment" "codebuild_policy" {
  role       = "${aws_iam_role.codebuild_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
