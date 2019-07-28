# -----------------------------------------------
# AWS CodePipeline
# -----------------------------------------------
resource "aws_codepipeline" "pipeline_frontend" {
  name     = "${local.project_name_uc}-Frontend"
  role_arn = "${aws_iam_role.pipeline_frontend_role.arn}"

  artifact_store {
    location = "${local.artifacts_bucket_name}"
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
        Owner      = "${local.frontend_owner}"
        Repo       = "${local.frontend_repo}"
        Branch     = "${local.frontend_branch}"
        OAuthToken = "${local.github_token}"
      }
    }

    # action {
    #   name             = "Automation"
    #   category         = "Source"
    #   owner            = "ThirdParty"
    #   provider         = "GitHub"
    #   version          = "1"
    #   output_artifacts = ["automate"]
    #   configuration = {
    #     Owner      = "${local.devops_owner}"
    #     Repo       = "${local.devops_repo}"
    #     Branch     = "${local.devops_branch}"
    #     OAuthToken = "${local.github_token}"
    #   }
    # }
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
# AWS CodePipeline IAM Role
# -----------------------------------------------
resource "aws_iam_role" "pipeline_frontend_role" {
  name               = "${local.project_name_uc}_CodePipeline_FrontendRole"
  assume_role_policy = "${data.aws_iam_policy_document.codepipeline_principals.json}"
  lifecycle {
    create_before_destroy = false
  }
}
resource "aws_iam_role_policy" "pipeline_frontend_policy" {
  depends_on = ["aws_iam_role.pipeline_frontend_role"]
  role       = "${aws_iam_role.pipeline_frontend_role.id}"
  policy     = "${data.aws_iam_policy_document.codepipeline_policy.json}"
}
