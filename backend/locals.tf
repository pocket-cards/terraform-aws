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
  parallelism         = "--parallelism=30"
  # -----------------------------------------------
  # API Gateway
  # -----------------------------------------------
  # api_base_path = "cards"
  api_gateway_files = [
    "${filemd5("apigateway.tf")}",
    "${filemd5("lambda_A0.tf")}",
    "${filemd5("lambda_B0.tf")}",
    "${filemd5("lambda_C0.tf")}",
    "${filemd5("lambda_D0.tf")}",
    "${filemd5("lambda_E0.tf")}",
    "${filemd5("lambda_S0.tf")}",
  ]
  api_gateway_deployment_md5 = "${base64encode(join("", local.api_gateway_files))}"

  # -----------------------------------------------
  # Cognito
  # -----------------------------------------------
  # identity_pool_arn = "${local.remote_main.identity_pool_arn}"
  # -----------------------------------------------
  # CodePipeline
  # -----------------------------------------------
  github_token = "${data.aws_ssm_parameter.github_token.value}"
  # -----------------------------------------------
  # CodeBuild
  # -----------------------------------------------
  build_type             = "LINUX_CONTAINER"
  build_compute_type     = "BUILD_GENERAL1_SMALL"
  build_image            = "aws/codebuild/standard:2.0"
  github_repo_branch     = "${local.environment == "prod" ? "master" : "dev"}"
  github_organization    = "${local.remote_unmu.github_organization}"
  github_repo_backend    = "${local.remote_unmu.github_repo_backend}"
  github_repo_automation = "${local.remote_unmu.github_repo_automation}"
  # -----------------------------------------------
  # S3 Bucket
  # -----------------------------------------------
  bucket_name_audios    = "${local.remote_unmu.bucket_name_audios}"
  bucket_name_images    = "${local.remote_unmu.bucket_name_images}"
  bucket_name_logging   = "${local.remote_unmu.bucket_name_logging}"
  bucket_name_artifacts = "${local.remote_init.bucket_name_artifacts}"
  # -----------------------------------------------
  # DynamoDB
  # -----------------------------------------------
  dynamodb_name_users       = "${local.remote_unmu.dynamodb_name_users}"
  dynamodb_name_user_groups = "${local.remote_unmu.dynamodb_name_user_groups}"
  dynamodb_name_group_words = "${local.remote_unmu.dynamodb_name_group_words}"
  dynamodb_name_words       = "${local.remote_unmu.dynamodb_name_words}"
  dynamodb_name_history     = "${local.remote_unmu.dynamodb_name_history}"

  # -----------------------------------------------
  # API Gateway
  # -----------------------------------------------
  api_gateway_domain         = "${aws_api_gateway_rest_api.this.id}.execute-api.${local.region}.amazonaws.com"
  api_endpoint_configuration = "REGIONAL"

  status_200       = { statusCode = 200 }
  response_version = { version = "${var.app_ver}" }

  # -----------------------------------------------
  # Cognito
  # -----------------------------------------------
  cognito_identity_pool_id = "${local.remote_unmu.cognito_identity_pool_id}"
  cognito_user_pool_id     = "${data.aws_cognito_user_pools.this.id}"

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
  lambda_handler              = "index.handler"
  lambda_runtime              = "nodejs10.x"
  lambda_alias_name           = "${local.environment}"
  audio_path_pattern          = "audio"
  lambda_role_prefix          = "${local.project_name_uc}_Lambda"
  lambda_function_name_prefix = "${local.project_name_uc}"
  lambda = {
    A001 = {
      function_name = "${local.lambda_function_name_prefix}_A001"
      role_name     = "${local.lambda_role_prefix}_A001Role"
    }
    A002 = {
      function_name = "${local.lambda_function_name_prefix}_A002"
      role_name     = "${local.lambda_role_prefix}_A002Role"
    }
    A003 = {
      function_name = "${local.lambda_function_name_prefix}_A003"
      role_name     = "${local.lambda_role_prefix}_A003Role"
    }
    B001 = {
      function_name = "${local.lambda_function_name_prefix}_B001"
      role_name     = "${local.lambda_role_prefix}_B001Role"
    }
    B002 = {
      function_name = "${local.lambda_function_name_prefix}_B002"
      role_name     = "${local.lambda_role_prefix}_B002Role"
    }
    B003 = {
      function_name = "${local.lambda_function_name_prefix}_B003"
      role_name     = "${local.lambda_role_prefix}_B003Role"
    }
    B004 = {
      function_name = "${local.lambda_function_name_prefix}_B004"
      role_name     = "${local.lambda_role_prefix}_B004Role"
    }
    C001 = {
      function_name = "${local.lambda_function_name_prefix}_C001"
      role_name     = "${local.lambda_role_prefix}_C001Role"
    }
    C002 = {
      function_name = "${local.lambda_function_name_prefix}_C002"
      role_name     = "${local.lambda_role_prefix}_C002Role"
    }
    C003 = {
      function_name = "${local.lambda_function_name_prefix}_C003"
      role_name     = "${local.lambda_role_prefix}_C003Role"
    }
    C004 = {
      function_name = "${local.lambda_function_name_prefix}_C004"
      role_name     = "${local.lambda_role_prefix}_C004Role"
    }
    C006 = {
      function_name = "${local.lambda_function_name_prefix}_C006"
      role_name     = "${local.lambda_role_prefix}_C006Role"
    }
    C007 = {
      function_name = "${local.lambda_function_name_prefix}_C007"
      role_name     = "${local.lambda_role_prefix}_C007Role"
    }
    C008 = {
      function_name = "${local.lambda_function_name_prefix}_C008"
      role_name     = "${local.lambda_role_prefix}_C008Role"
    }
    D001 = {
      function_name = "${local.lambda_function_name_prefix}_D001"
      role_name     = "${local.lambda_role_prefix}_D001Role"
    }
    S001 = {
      function_name = "${local.lambda_function_name_prefix}_S001"
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

data "aws_cognito_user_pools" "this" {
  name = "${local.remote_unmu.cognito_user_pool_name}"
}
