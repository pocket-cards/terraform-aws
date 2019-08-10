
# -----------------------------------------------
# AWS Codebuild - Backend publish
# -----------------------------------------------
resource "aws_codebuild_project" "codebuild_backend_publish" {
  depends_on = ["aws_iam_role.codebuild_backend_publish_role"]

  name          = "${local.project_name_uc}-BackendPublish"
  build_timeout = "5"
  service_role  = "${aws_iam_role.codebuild_backend_publish_role.arn}"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    type                        = "${local.build_type}"
    compute_type                = "${local.build_compute_type}"
    image                       = "${local.build_image}"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "PROJECT_NAME"
      value = "${local.project_name_uc}"
    }

    environment_variable {
      name  = "APPLICATION_NAME"
      value = "${aws_codedeploy_app.backend.name}"
    }

    environment_variable {
      name  = "FUNCTION_ALIAS"
      value = "${local.environment}"
    }

    environment_variable {
      name  = "ARTIFACTS_BUCKET"
      value = "${local.artifacts_bucket_name}"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "publish/buildspec.yml"
  }
}

# -----------------------------------------------
# AWS Codebuild IAM Role
# -----------------------------------------------
resource "aws_iam_role" "codebuild_backend_publish_role" {
  name               = "${local.project_name_uc}_CodeBuild_BackendPublishRole"
  assume_role_policy = "${data.aws_iam_policy_document.codebuild_principals.json}"
  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_iam_role_policy" "codebuild_backend_publish_policy" {
  depends_on = ["aws_iam_role.codebuild_backend_publish_role"]
  role       = "${aws_iam_role.codebuild_backend_publish_role.name}"
  policy     = "${data.aws_iam_policy_document.codebuild_policy.json}"
}
