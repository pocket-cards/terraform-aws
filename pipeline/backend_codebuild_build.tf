# -----------------------------------------------
# AWS Codebuild - Backend build
# -----------------------------------------------
resource "aws_codebuild_project" "codebuild_backend_build" {
  depends_on = ["aws_iam_role.codebuild_backend_build_role"]

  name          = "${local.project_name_uc}-BackendBuild"
  build_timeout = "5"
  service_role  = "${aws_iam_role.codebuild_backend_build_role.arn}"

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
    buildspec = "build/buildspec.yml"
  }
}

# -----------------------------------------------
# AWS Codebuild IAM Role
# -----------------------------------------------
resource "aws_iam_role" "codebuild_backend_build_role" {
  name               = "${local.project_name_uc}_CodeBuild_BackendBuildRole"
  assume_role_policy = "${data.aws_iam_policy_document.codebuild_principals.json}"
  lifecycle {
    create_before_destroy = false
  }
}

# -----------------------------------------------
# AWS Codebuild IAM Policy
# -----------------------------------------------
resource "aws_iam_role_policy" "codebuild_backend_build_policy" {
  depends_on = ["aws_iam_role.codebuild_backend_build_role"]
  role       = "${aws_iam_role.codebuild_backend_build_role.name}"
  policy     = "${data.aws_iam_policy_document.codebuild_policy.json}"
}
