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
  # S3 Bucket
  # -----------------------------------------------
  bucket_frontend_name = "${local.remote_unmu.bucket_frontend_name}"
  bucket_audios_name   = "${local.remote_unmu.bucket_audios_name}"
  bucket_images_name   = "${local.remote_unmu.bucket_images_name}"
  bucket_logging_name  = "${local.remote_unmu.bucket_logging_name}"
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
  # API Base Path Mappings
  # -----------------------------------------------
  rest_api_base_path = "cards"

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
  alias_name         = "${local.environment}"
  lambda_handler     = "index.handler"
  lambda_runtime     = "nodejs10.x"
  audio_path_pattern = "audio"
}

data "aws_region" "this" {}
data "aws_route53_zone" "this" {
  name = "${local.remote_init.domain_name}"
}
