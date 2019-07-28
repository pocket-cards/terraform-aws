# -----------------------------------------------
# AWS Codebuild
# -----------------------------------------------
resource "aws_codebuild_project" "codebuild_frontend" {
  depends_on = ["aws_iam_role.codebuild_frontend_role"]

  name          = "${local.project_name_uc}-Frontend"
  build_timeout = "5"
  service_role  = "${aws_iam_role.codebuild_frontend_role.arn}"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/nodejs:10.14.1"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "BUCKET_WEB"
      value = "${local.web_bucket_id}"
    }

    environment_variable {
      name  = "CLOUDFRONT_ID"
      value = "${local.cloudfront_id}"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "frontend/buildspec.yml"
  }
}

# -----------------------------------------------
# AWS Codebuild IAM Role
# -----------------------------------------------
resource "aws_iam_role" "codebuild_frontend_role" {
  name               = "${local.project_name}_CodeBuild_FrontendBuildRole"
  assume_role_policy = "${data.aws_iam_policy_document.codebuild_principals.json}"
  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_iam_role_policy" "codebuild_frontend_policy" {
  depends_on = ["aws_iam_role.codebuild_frontend_role"]
  role       = "${aws_iam_role.codebuild_frontend_role.name}"
  policy     = "${data.aws_iam_policy_document.codebuild_policy_frontend.json}"
}
