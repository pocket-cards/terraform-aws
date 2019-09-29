# -----------------------------------------------
# AWS CodePipeline - Backend
# -----------------------------------------------
resource "aws_codepipeline" "backend" {
  name     = "${local.project_name_uc}-Backend"
  role_arn = "${aws_iam_role.codepipeline_role_backend.arn}"

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
        Repo                 = "${local.github_repo_backend}"
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
        ProjectName = "${aws_codebuild_project.codebuild_backend_build.name}"
      }
    }
  }

  stage {
    name = "Publish"
    action {
      name             = "Publish"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source", "build_artf"]
      output_artifacts = ["pub_artf"]
      version          = "1"

      configuration = {
        ProjectName   = "${aws_codebuild_project.codebuild_backend_publish.name}"
        PrimarySource = "source"
      }
    }
  }
}

# -----------------------------------------------
# AWS CodePipeline IAM Role - Backend
# -----------------------------------------------
resource "aws_iam_role" "codepipeline_role_backend" {
  name               = "${local.project_name_uc}_CodePipeline_BackendRole"
  assume_role_policy = "${file("iam/codepipeline_principals.json")}"
  lifecycle {
    create_before_destroy = false
  }
}

# -----------------------------------------------
# AWS CodePipeline IAM Role Policy - Backend
# -----------------------------------------------
resource "aws_iam_role_policy" "codepipeline_policy_backend" {
  role   = "${aws_iam_role.codepipeline_role_backend.id}"
  policy = "${file("iam/codepipeline_policy.json")}"
}


# -----------------------------------------------
# AWS CodePipeline Webhook
# -----------------------------------------------
resource "aws_codepipeline_webhook" "backend" {
  name            = "${local.project_name_uc}-BackendWebhook"
  authentication  = "GITHUB_HMAC"
  target_action   = "Source"
  target_pipeline = "${aws_codepipeline.backend.name}"

  authentication_configuration {
    secret_token = "${local.github_token}"
  }

  filter {
    json_path    = "$.ref"
    match_equals = "refs/heads/${local.github_repo_branch}"
  }
}

# -----------------------------------------------
# Github Repository
# -----------------------------------------------
data "github_repository" "backend" {
  full_name = "${local.github_organization}/${local.github_repo_backend}"
}

# -----------------------------------------------
# Github Repository Webhook
# -----------------------------------------------
resource "github_repository_webhook" "backend" {
  repository = "${data.github_repository.backend.name}"

  configuration {
    url          = "${aws_codepipeline_webhook.backend.url}"
    content_type = "json"
    insecure_ssl = true
    secret       = "${local.github_token}"
  }

  events = ["push"]
}

# -----------------------------------------------
# AWS CodePipeline - Automation
# -----------------------------------------------
resource "aws_codepipeline" "automation" {
  name     = "${local.project_name_uc}-Automation"
  role_arn = "${aws_iam_role.codepipeline_role_automation.arn}"

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
        Repo                 = "${local.github_repo_automation}"
        Branch               = "${local.github_repo_branch}"
        OAuthToken           = "${local.github_token}"
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
      input_artifacts = ["source"]
      version         = "1"

      configuration = {
        ProjectName = "${aws_codebuild_project.codebuild_automation.name}"
      }
    }
  }
}

# -----------------------------------------------
# AWS CodePipeline IAM Role - Automation
# -----------------------------------------------
resource "aws_iam_role" "codepipeline_role_automation" {
  name               = "${local.project_name_uc}_CodePipeline_AutomationRole"
  assume_role_policy = "${file("iam/codepipeline_principals.json")}"
  lifecycle {
    create_before_destroy = false
  }
}

# -----------------------------------------------
# AWS CodePipeline IAM Role Policy - Automation
# -----------------------------------------------
resource "aws_iam_role_policy" "codepipeline_automation_policy" {
  role   = "${aws_iam_role.codepipeline_role_automation.id}"
  policy = "${file("iam/codepipeline_policy.json")}"
}


# -----------------------------------------------
# AWS CodePipeline Webhook - Automation
# -----------------------------------------------
resource "aws_codepipeline_webhook" "automation" {
  name            = "${local.project_name_uc}-AutomationWebhook"
  authentication  = "GITHUB_HMAC"
  target_action   = "Source"
  target_pipeline = "${aws_codepipeline.automation.name}"

  authentication_configuration {
    secret_token = "${local.github_token}"
  }

  filter {
    json_path    = "$.ref"
    match_equals = "refs/heads/${local.github_repo_branch}"
  }
}

# -----------------------------------------------
# Github Repository - Automation
# -----------------------------------------------
data "github_repository" "automation" {
  full_name = "${local.github_organization}/${local.github_repo_automation}"
}

# -----------------------------------------------
# Github Repository Webhook - Automation
# -----------------------------------------------
resource "github_repository_webhook" "automation" {
  repository = "${data.github_repository.automation.name}"

  configuration {
    url          = "${aws_codepipeline_webhook.automation.url}"
    content_type = "json"
    insecure_ssl = true
    secret       = "${local.github_token}"
  }

  events = ["push"]
}
