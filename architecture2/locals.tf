locals {
  # -----------------------------------------------
  # Project Informations
  # -----------------------------------------------
  remote_init = "${data.terraform_remote_state.initialize.outputs}"
  remote_unmu = "${data.terraform_remote_state.unmutable.outputs}"

  project_name    = "${local.remote_init.project_name}"
  project_name_uc = "${local.remote_init.project_name_uc}"
  environment     = "${terraform.workspace}"
  region          = "${data.aws_region.this.name}"
  region_us       = "us-east-1"
  # timezone        = "${var.timezone}"
  # translation_url     = "${local.remote_init.translation_url}"
  # translation_api_key = "${local.remote_init.ssm_param_translation_api_key}"
  # ipa_url             = "${local.remote_init.ipa_url}"
  # ipa_api_key         = "${local.remote_init.ssm_param_ipa_api_key}"


  # -----------------------------------------------
  # CloudFront
  # -----------------------------------------------
  origin_id_frontend     = "frontend"
  origin_id_audio        = "audio"
  origin_id_api          = "api"
  origin_id_path         = "/cards"
  default_root_object    = "index.html"
  viewer_protocol_policy = "redirect-to-https"
  logging_prefix         = "frontend"
  audio_path_pattern     = "${local.origin_id_audio}"

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
  # -----------------------------------------------
  # DynamoDB
  # -----------------------------------------------
  # dynamodb_users_name       = "${local.remote_init.dynamodb_users_name}"
  # dynamodb_user_groups_name = "${local.remote_init.dynamodb_user_groups_name}"
  # dynamodb_group_words_name = "${local.remote_unmu.dynamodb_group_words_name}"
  # dynamodb_words_name       = "${local.remote_init.dynamodb_words_name}"
  # dynamodb_history_name     = "${local.remote_init.dynamodb_history_name}"

  # -----------------------------------------------
  # API Gateway
  # -----------------------------------------------
  # rest_api_id            = "${local.remote_api.rest_api_id}"
  # rest_api_execution_arn = "${local.remote_api.rest_api_execution_arn}"
  # api_gateway_domain     = "${local.rest_api_id}.execute-api.${local.region}.amazonaws.com"

  # -----------------------------------------------
  # Route53
  # -----------------------------------------------
  # route53_ttl       = "300"
  # record_type_cname = "CNAME"

  # -----------------------------------------------
  # Lambda Layers
  # -----------------------------------------------
  # xray   = "${local.remote_unmu.layers.xray}"
  # moment = "${local.remote_unmu.layers.moment}"
  # lodash = "${local.remote_unmu.layers.lodash}"
  # axios  = "${local.remote_unmu.layers.axios}"

  # -----------------------------------------------
  # Lambda 
  # -----------------------------------------------
  # alias_name     = "${local.environment}"
  # lambda_handler = "index.handler"
  # lambda_runtime = "nodejs10.x"
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
