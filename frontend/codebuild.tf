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

  cache {
    location = "${local.bucket_name_artifacts}/cache"
    type     = "S3"
  }

  environment {
    type                        = "${local.build_type}"
    compute_type                = "${local.build_compute_type}"
    image                       = "${local.build_image}"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "BUCKET_WEB"
      value = "${local.bucket_name_frontend}"
    }

    environment_variable {
      name  = "CLOUDFRONT_ID"
      value = "${aws_cloudfront_distribution.this.id}"
    }

    environment_variable {
      name  = "API_URL"
      value = "https://${local.api_domain_name}"
    }
    environment_variable {
      name  = "IDENTITY_POOL_ID"
      value = "${local.cognito_identity_pool_id}"
    }
    environment_variable {
      name  = "USER_POOL_ID"
      value = "${local.cognito_user_pool_id}"
    }
    environment_variable {
      name  = "USER_POOL_WEB_CLIENT_ID"
      value = "${local.cognito_web_client_id}"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }
}

# -----------------------------------------------
# AWS Codebuild IAM Role
# -----------------------------------------------
resource "aws_iam_role" "codebuild_frontend_role" {
  name               = "${local.project_name_uc}_CodeBuild_FrontendRole"
  assume_role_policy = "${file("iam/codebuild_principals.json")}"
  lifecycle {
    create_before_destroy = false
  }
}

# -----------------------------------------------
# AWS Codebuild IAM Policy - Frontend
# -----------------------------------------------
resource "aws_iam_policy" "codebuild_frontend_policy" {
  name   = "${local.project_name_uc}_CodeBuild_FrontendPolicy"
  policy = "${file("iam/codebuild_policy.json")}"
}

# -----------------------------------------------
# AWS Codebuild IAM Role Policy Attachment - Backend Build
# -----------------------------------------------
resource "aws_iam_role_policy_attachment" "codebuild_frontend_attach" {
  role       = "${aws_iam_role.codebuild_frontend_role.name}"
  policy_arn = "${aws_iam_policy.codebuild_frontend_policy.arn}"
}
