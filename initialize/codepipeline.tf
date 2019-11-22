# -----------------------------------------------
# AWS CodePipeline
# -----------------------------------------------
resource "aws_codepipeline" "initialize" {
  name     = "${local.project_name_uc}-Initial"
  role_arn = "${aws_iam_role.codepipeline_role.arn}"

  artifact_store {
    location = "${local.bucket_name_artifacts}"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Terraform"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["infrastructure"]

      configuration = {
        OAuthToken           = "${var.github_token}"
        Owner                = "${var.github_organization}"
        Repo                 = "${var.github_repo}"
        Branch               = "master"
        PollForSourceChanges = false
      }
    }
  }

  stage {
    name = "Build"
    action {
      name            = "Build"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["infrastructure"]
      version         = "1"
      configuration = {
        ProjectName = "${aws_codebuild_project.initialize.name}"
      }
    }
  }
}

# -----------------------------------------------
# AWS CodePipeline IAM Role
# -----------------------------------------------
resource "aws_iam_role" "codepipeline_role" {
  name               = "${local.project_name_uc}_CodePipeline_InitializeRole"
  assume_role_policy = "${file("iam/codepipeline_principals.json")}"

  lifecycle {
    create_before_destroy = false
  }
}
# -----------------------------------------------
# AWS CodePipeline Policy
# -----------------------------------------------
resource "aws_iam_role_policy" "codepipeline_policy" {
  role   = "${aws_iam_role.codepipeline_role.id}"
  policy = "${file("iam/codepipeline_policy.json")}"
}

# -----------------------------------------------
# AWS CodePipeline Webhook
# -----------------------------------------------
resource "aws_codepipeline_webhook" "initialize" {
  name            = "${local.project_name_uc}-InitialWebhook"
  authentication  = "GITHUB_HMAC"
  target_action   = "Source"
  target_pipeline = "${aws_codepipeline.initialize.name}"

  authentication_configuration {
    secret_token = "${var.github_token}"
  }

  filter {
    json_path    = "${local.github_filter_json_path}"
    match_equals = "${local.github_filter_match_equals}"
  }
}

# -----------------------------------------------
# Github Repository
# -----------------------------------------------
data "github_repository" "terraform" {
  full_name = "${var.github_organization}/${var.github_repo}"
}

# -----------------------------------------------
# Github Repository Webhook
# -----------------------------------------------
resource "github_repository_webhook" "terraform" {
  repository = "${data.github_repository.terraform.name}"

  configuration {
    url          = "${aws_codepipeline_webhook.initialize.url}"
    content_type = "json"
    insecure_ssl = true
    secret       = "${var.github_token}"
  }

  events = ["${local.github_events}"]
}
