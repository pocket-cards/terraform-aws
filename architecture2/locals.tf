locals {
  # -----------------------------------------------
  # Project Informations
  # -----------------------------------------------
  remote_init = "${data.terraform_remote_state.initialize.outputs}"
  remote_unmu = "${data.terraform_remote_state.unmutable.outputs}"
  remote_bked = "${data.terraform_remote_state.backend.outputs}"

  project_name    = "${local.remote_init.project_name}"
  project_name_uc = "${local.remote_init.project_name_uc}"
  environment     = "${terraform.workspace}"
  region          = "${data.aws_region.this.name}"
  region_us       = "us-east-1"

  # -----------------------------------------------
  # API Gateway
  # -----------------------------------------------
  api_domain_name   = "${local.remote_bked.api_domain_name}"
  api_execution_arn = "${local.remote_bked.api_execution_arn}"

  # -----------------------------------------------
  # CloudFront
  # -----------------------------------------------
  origin_id_frontend     = "frontend"
  origin_id_audio        = "audio"
  origin_id_api          = "api"
  origin_id_path         = "/api"
  default_root_object    = "index.html"
  viewer_protocol_policy = "redirect-to-https"
  logging_prefix         = "frontend"
  audio_path_pattern     = "${local.origin_id_audio}"
  api_path_pattern       = "${local.origin_id_api}"
  # -----------------------------------------------
  # CloudTrail
  # -----------------------------------------------
  ct_prefix = "trail"

  # -----------------------------------------------
  # S3 Bucket
  # -----------------------------------------------
  bucket_frontend_name  = "${local.remote_unmu.bucket_frontend_name}"
  bucket_audios_name    = "${local.remote_unmu.bucket_audios_name}"
  bucket_logging_name   = "${local.remote_unmu.bucket_logging_name}"
  bucket_artifacts_name = "${local.remote_init.bucket_artifacts_name}"

  # -----------------------------------------------
  # CodeBuild
  # -----------------------------------------------
  build_type         = "LINUX_CONTAINER"
  build_compute_type = "BUILD_GENERAL1_SMALL"
  build_image        = "aws/codebuild/standard:2.0"
  frontend_repo      = "${local.remote_unmu.frontend_repo}"
  frontend_owner     = "${local.remote_unmu.frontend_owner}"
  frontend_branch    = "${local.remote_unmu.frontend_branch}"
}

data "aws_caller_identity" "this" {
}
# -----------------------------------------------
# AWS Region
# -----------------------------------------------
data "aws_region" "this" {}
# -----------------------------------------------
# AWS Route53
# -----------------------------------------------
data "aws_route53_zone" "this" {
  name = "${local.remote_init.domain_name}"
}
# -----------------------------------------------
# Amazon S3 Bucket - Frontend
# -----------------------------------------------
data "aws_s3_bucket" "frontend" {
  bucket = "${local.bucket_frontend_name}"
}
# -----------------------------------------------
# Amazon S3 Bucket - Audios
# -----------------------------------------------
data "aws_s3_bucket" "audios" {
  bucket = "${local.bucket_audios_name}"
}
# -----------------------------------------------
# SSM Parameter Store - Github token
# -----------------------------------------------
data "aws_ssm_parameter" "github_token" {
  name = "${local.remote_init.ssm_param_github_token}"
}
