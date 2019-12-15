# -----------------------------------------------
# Amazon CloudWatch Rule: CodeBuild
# -----------------------------------------------
resource "aws_cloudwatch_event_rule" "codebuild" {
  name        = "${local.project_name_uc}_CodeBuildError"
  description = "CodeBuild State Error Rule"
  event_pattern = file("pattern/event_rule_codebuild.json")
}

# -----------------------------------------------
# Amazon CloudWatch Event Target: CodeBuild
# -----------------------------------------------
resource "aws_cloudwatch_event_target" "codebuild" {
  rule = aws_cloudwatch_event_rule.codebuild.name
  arn = "${local.lambda_arn}:${local.lambda_function}_M002"
}

# -----------------------------------------------
# Amazon CloudWatch Rule: CodePipeline
# -----------------------------------------------
resource "aws_cloudwatch_event_rule" "codepipeline" {
  name        = "${local.project_name_uc}_CodePipelineSuccess"
  description = "CodePipeline State Success Rule"
  event_pattern = file("pattern/event_rule_codepipeline.json")
}

# -----------------------------------------------
# Amazon CloudWatch Event Target: CodePipeline
# -----------------------------------------------
resource "aws_cloudwatch_event_target" "codepipeline" {
  rule = aws_cloudwatch_event_rule.codepipeline.name
  arn = "${local.lambda_arn}:${local.lambda_function}_M003"
}

