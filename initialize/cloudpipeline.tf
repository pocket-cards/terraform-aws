# -----------------------------------------------
# AWS CodePipeline
# -----------------------------------------------
resource "aws_codepipeline" "initialize" {
  name     = "${local.project_name_stn}-Init"
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
        OAuthToken = "${var.github_token}"
        Owner      = "${var.github_owner}"
        Repo       = "${var.github_repo}"
        Branch     = "${var.github_branch}"
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
# AWS CodePipeline Principals
# -----------------------------------------------
data "aws_iam_policy_document" "codepipeline_principals" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

# -----------------------------------------------
# AWS CodePipeline IAM Role
# -----------------------------------------------
resource "aws_iam_role" "codepipeline_role" {
  name               = "${local.project_name_uc}_CodePipeline_InitializeRole"
  assume_role_policy = "${data.aws_iam_policy_document.codepipeline_principals.json}"

  lifecycle {
    create_before_destroy = false
  }
}
# -----------------------------------------------
# AWS CodePipeline Policy
# -----------------------------------------------
resource "aws_iam_role_policy" "codepipeline_policy" {
  depends_on = ["aws_iam_role.codepipeline_role"]
  role       = "${aws_iam_role.codepipeline_role.id}"
  policy     = "${data.aws_iam_policy_document.codepipeline_policy_data.json}"
}


# -----------------------------------------------
# AWS CodePipeline Policy Data
# -----------------------------------------------
data "aws_iam_policy_document" "codepipeline_policy_data" {
  statement {
    effect = "Allow"

    actions = [
      "codedeploy:CreateDeployment",
      "codedeploy:GetApplication",
      "codedeploy:GetApplicationRevision",
      "codedeploy:GetDeployment",
      "codedeploy:GetDeploymentConfig",
      "codedeploy:RegisterApplicationRevision",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "elasticbeanstalk:*",
      "ec2:*",
      "elasticloadbalancing:*",
      "autoscaling:*",
      "cloudwatch:*",
      "s3:*",
      "sns:*",
      "cloudformation:*",
      "rds:*",
      "sqs:*",
      "ecs:*",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "lambda:InvokeFunction",
      "lambda:ListFunctions",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "opsworks:CreateDeployment",
      "opsworks:DescribeApps",
      "opsworks:DescribeCommands",
      "opsworks:DescribeDeployments",
      "opsworks:DescribeInstances",
      "opsworks:DescribeStacks",
      "opsworks:UpdateApp",
      "opsworks:UpdateStack",
      "cloudformation:CreateStack",
      "cloudformation:DeleteStack",
      "cloudformation:DescribeStacks",
      "cloudformation:UpdateStack",
      "cloudformation:CreateChangeSet",
      "cloudformation:DeleteChangeSet",
      "cloudformation:DescribeChangeSet",
      "cloudformation:ExecuteChangeSet",
      "cloudformation:SetStackPolicy",
      "cloudformation:ValidateTemplate",
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
      "devicefarm:ListProjects",
      "devicefarm:ListDevicePools",
      "devicefarm:GetRun",
      "devicefarm:GetUpload",
      "devicefarm:CreateUpload",
      "devicefarm:ScheduleRun",
      "servicecatalog:ListProvisioningArtifacts",
      "servicecatalog:CreateProvisioningArtifact",
      "servicecatalog:DescribeProvisioningArtifact",
      "servicecatalog:DeleteProvisioningArtifact",
      "servicecatalog:UpdateProduct",
      "ecr:DescribeImages",
    ]

    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = ["*"]

    condition {
      test     = "StringEqualsIfExists"
      variable = "iam:PassedToService"

      values = [
        "cloudformation.amazonaws.com",
        "elasticbeanstalk.amazonaws.com",
        "ec2.amazonaws.com",
        "ecs-tasks.amazonaws.com",
      ]
    }
  }
}
