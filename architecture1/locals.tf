locals {
  # -----------------------------------------------
  # Project Informations
  # -----------------------------------------------
  remote_init = "${data.terraform_remote_state.initialize.outputs}"
  remote_unmu = "${data.terraform_remote_state.unmutable.outputs}"

  project_name        = "${local.remote_init.project_name}"
  project_name_uc     = "${local.remote_init.project_name_uc}"
  region              = "${data.aws_region.this.name}"
  environment         = "${terraform.workspace}"
  region_us           = "us-east-1"
  timezone            = "Asia/Tokyo"
  translation_url     = "${local.remote_init.translation_url}"
  translation_api_key = "${local.remote_init.ssm_param_translation_api_key}"
  ipa_url             = "${local.remote_init.ipa_url}"
  ipa_api_key         = "${local.remote_init.ssm_param_ipa_api_key}"

  # -----------------------------------------------
  # API Base Path Mappings
  # -----------------------------------------------
  api_base_path = "cards"

  # -----------------------------------------------
  # Cognito
  # -----------------------------------------------
  # identity_pool_arn = "${local.remote_main.identity_pool_arn}"
  # -----------------------------------------------
  # CodeBuild
  # -----------------------------------------------
  build_type         = "LINUX_CONTAINER"
  build_compute_type = "BUILD_GENERAL1_SMALL"
  build_image        = "aws/codebuild/standard:2.0"
  backend_repo       = "${local.remote_unmu.backend_repo}"
  backend_owner      = "${local.remote_unmu.backend_owner}"
  backend_branch     = "${local.remote_unmu.backend_branch}"
  automation_repo    = "${local.remote_unmu.automation_repo}"
  automation_owner   = "${local.remote_unmu.automation_owner}"
  automation_branch  = "${local.remote_unmu.automation_branch}"
  # -----------------------------------------------
  # S3 Bucket
  # -----------------------------------------------
  bucket_audios_name    = "${local.remote_unmu.bucket_audios_name}"
  bucket_images_name    = "${local.remote_unmu.bucket_images_name}"
  bucket_logging_name   = "${local.remote_unmu.bucket_logging_name}"
  bucket_artifacts_name = "${local.remote_init.bucket_artifacts_name}"
  # -----------------------------------------------
  # DynamoDB
  # -----------------------------------------------
  dynamodb_users_name       = "${local.remote_unmu.dynamodb_users_name}"
  dynamodb_user_groups_name = "${local.remote_unmu.dynamodb_user_groups_name}"
  dynamodb_group_words_name = "${local.remote_unmu.dynamodb_group_words_name}"
  dynamodb_words_name       = "${local.remote_unmu.dynamodb_words_name}"
  dynamodb_history_name     = "${local.remote_unmu.dynamodb_history_name}"

  # -----------------------------------------------
  # API Gateway
  # -----------------------------------------------
  api_gateway_domain         = "${aws_api_gateway_rest_api.this.id}.execute-api.${local.region}.amazonaws.com"
  api_endpoint_configuration = "REGIONAL"

  status_200       = { statusCode = 200 }
  response_version = { version = "${var.app_ver}" }

  # -----------------------------------------------
  # Lambda Layers
  # -----------------------------------------------
  xray   = "${local.remote_init.layers.xray}"
  moment = "${local.remote_init.layers.moment}"
  lodash = "${local.remote_init.layers.lodash}"
  axios  = "${local.remote_init.layers.axios}"

  # -----------------------------------------------
  # Lambda
  # -----------------------------------------------
  lambda_handler     = "index.handler"
  lambda_runtime     = "nodejs10.x"
  lambda_alias_name  = "${local.environment}"
  audio_path_pattern = "audio"
  lambda_role_prefix = "${local.project_name_uc}_Lambda"
  lambda = {
    A001 = {
      function_name = "A001"
      role_name     = "${local.lambda_role_prefix}_A001Role"
    }
    A002 = {
      function_name = "A002"
      role_name     = "${local.lambda_role_prefix}_A002Role"
    }
    A003 = {
      function_name = "A003"
      role_name     = "${local.lambda_role_prefix}_A003Role"
    }
    B001 = {
      function_name = "B001"
      role_name     = "${local.lambda_role_prefix}_B001Role"
    }
    B002 = {
      function_name = "B002"
      role_name     = "${local.lambda_role_prefix}_B002Role"
    }
    B003 = {
      function_name = "B003"
      role_name     = "${local.lambda_role_prefix}_B003Role"
    }
    B004 = {
      function_name = "B004"
      role_name     = "${local.lambda_role_prefix}_B004Role"
    }
    C001 = {
      function_name = "C001"
      role_name     = "${local.lambda_role_prefix}_C001Role"
    }
    C002 = {
      function_name = "C002"
      role_name     = "${local.lambda_role_prefix}_C002Role"
    }
    C003 = {
      function_name = "C003"
      role_name     = "${local.lambda_role_prefix}_C003Role"
    }
    C004 = {
      function_name = "C004"
      role_name     = "${local.lambda_role_prefix}_C004Role"
    }
    C006 = {
      function_name = "C006"
      role_name     = "${local.lambda_role_prefix}_C006Role"
    }
    C007 = {
      function_name = "C007"
      role_name     = "${local.lambda_role_prefix}_C007Role"
    }
    C008 = {
      function_name = "C008"
      role_name     = "${local.lambda_role_prefix}_C008Role"
    }
    D001 = {
      function_name = "D001"
      role_name     = "${local.lambda_role_prefix}_D001Role"
    }
    S001 = {
      function_name = "S001"
      role_name     = "${local.lambda_role_prefix}_S001Role"
    }
  }

  deployment_group_names = [
    "A002", "A003",
    "C001", "C002", "C003", "C004", "C005", "C006", "C007", "C008",
    "D001", "E001",
    "S001", "S002"
  ]
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
# SSM Parameter Store - Github token
# -----------------------------------------------
data "aws_ssm_parameter" "github_token" {
  name = "${local.remote_init.ssm_param_github_token}"
}
