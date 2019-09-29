# -----------------------------------------------
# AWS CodePipeline - Frontend
# -----------------------------------------------
resource "aws_codepipeline" "frontend" {
  depends_on = ["aws_iam_role.pipeline_frontend"]

  name     = "${local.project_name_uc}-Frontend"
  role_arn = "${aws_iam_role.pipeline_frontend.arn}"

  artifact_store {
    location = "${local.bucket_name_artifacts}"
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "Backend"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source"]
      configuration = {
        Owner                = "${local.github_organization}"
        Repo                 = "${local.github_repo_frontend}"
        Branch               = "${local.github_repo_branch}"
        OAuthToken           = "${local.github_token}"
        PollForSourceChanges = false
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source"]
      output_artifacts = ["build_artf"]
      version          = "1"

      configuration = {
        ProjectName = "${aws_codebuild_project.codebuild_frontend.name}"
      }
    }
  }

  # stage {
  #   name = "Deploy"
  #   action {
  #     name            = "Deploy"
  #     category        = "Deploy"
  #     owner           = "AWS"
  #     provider        = "S3"
  #     input_artifacts = ["build_artf"]
  #     version         = "1"

  #     configuration = {
  #       BucketName = "pocket-cards-web"
  #       Extract    = true
  #     }
  #   }
  # }
}

# -----------------------------------------------
# AWS CodePipeline IAM Role - Frontend
# -----------------------------------------------
resource "aws_iam_role" "pipeline_frontend" {
  name               = "${local.project_name_uc}_CodePipeline_FrontendRole"
  assume_role_policy = "${file("iam/codepipeline_principals.json")}"
  lifecycle {
    create_before_destroy = false
  }
}
resource "aws_iam_role_policy" "pipeline_frontend" {
  depends_on = ["aws_iam_role.pipeline_frontend"]

  role   = "${aws_iam_role.pipeline_frontend.id}"
  policy = "${file("iam/codepipeline_policy.json")}"

  lifecycle {
    create_before_destroy = false
  }
}



# -----------------------------------------------
# AWS CodePipeline Webhook - Frontend
# -----------------------------------------------
resource "aws_codepipeline_webhook" "frontend" {
  name            = "${local.project_name_uc}-FrontendWebhook"
  authentication  = "GITHUB_HMAC"
  target_action   = "Source"
  target_pipeline = "${aws_codepipeline.frontend.name}"

  authentication_configuration {
    secret_token = "${local.github_token}"
  }

  filter {
    json_path    = "$.ref"
    match_equals = "refs/heads/${local.github_repo_branch}"
  }
}

# -----------------------------------------------
# Github Repository - Frontend
# -----------------------------------------------
data "github_repository" "frontend" {
  full_name = "${local.github_organization}/${local.github_repo_frontend}"
}

# -----------------------------------------------
# Github Repository Webhook - Frontend
# -----------------------------------------------
resource "github_repository_webhook" "frontend" {
  repository = "${data.github_repository.frontend.name}"

  configuration {
    url          = "${aws_codepipeline_webhook.frontend.url}"
    content_type = "json"
    insecure_ssl = true
    secret       = "${local.github_token}"
  }

  events = ["push"]
}
