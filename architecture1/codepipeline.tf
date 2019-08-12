# -----------------------------------------------
# AWS CodePipeline
# -----------------------------------------------
resource "aws_codepipeline" "codepipeline_backend" {
  name     = "${local.project_name_uc}-Backend"
  role_arn = "${aws_iam_role.codepipeline_backend_role.arn}"

  artifact_store {
    location = "${local.bucket_artifacts_name}"
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
        Owner      = "${local.backend_owner}"
        Repo       = "${local.backend_repo}"
        Branch     = "${local.backend_branch}"
        OAuthToken = "${data.aws_ssm_parameter.github_token.value}"
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
# AWS CodePipeline IAM Role
# -----------------------------------------------
resource "aws_iam_role" "codepipeline_backend_role" {
  name               = "${local.project_name_uc}_CodePipeline_BackendRole"
  assume_role_policy = "${file("iam/codepipeline_principals.json")}"
  lifecycle {
    create_before_destroy = false
  }
}

# -----------------------------------------------
# AWS CodePipeline IAM Role Policy
# -----------------------------------------------
resource "aws_iam_role_policy" "codepipeline_backend_policy" {
  role   = "${aws_iam_role.codepipeline_backend_role.id}"
  policy = "${file("iam/codepipeline_policy.json")}"
}
