locals {
  # -----------------------------------------------
  # Project Informations
  # -----------------------------------------------
  remote_init = "${data.terraform_remote_state.initialize.outputs}"
  remote_unmu = "${data.terraform_remote_state.unmutable.outputs}"

  project_name        = "${local.remote_init.project_name}"
  project_name_uc     = "${local.remote_init.project_name_uc}"
  region              = "${local.remote_init.region}"
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
  identity_pool_arn = "${local.remote_main.identity_pool_arn}"

  # -----------------------------------------------
  # S3 Bucket
  # -----------------------------------------------
  # web_bucket_id                   = "${local.remote_init.web_bucket_name}"
  # web_bucket_arn                  = "${local.remote_init.web_bucket_arn}"
  # web_bucket_regional_domain_name = "${local.remote_init.web_bucket_regional_domain_name}"

  audios_bucket_id                   = "${local.remote_init.audios_bucket_name}"
  audios_bucket_arn                  = "${local.remote_init.audios_bucket_arn}"
  audios_bucket_regional_domain_name = "${local.remote_init.audios_bucket_regional_domain_name}"

  images_bucket_id                   = "${local.remote_init.images_bucket_name}"
  images_bucket_arn                  = "${local.remote_init.images_bucket_arn}"
  images_bucket_regional_domain_name = "${local.remote_init.images_bucket_regional_domain_name}"

  logging_bucket_id                   = "${local.remote_init.logging_bucket_name}"
  logging_bucket_arn                  = "${local.remote_init.logging_bucket_arn}"
  logging_bucket_regional_domain_name = "${local.remote_init.logging_bucket_regional_domain_name}"
  # -----------------------------------------------
  # DynamoDB
  # -----------------------------------------------
  dynamodb_users_name             = "${local.remote_init.dynamodb_users_name}"
  dynamodb_users_arn              = "${local.remote_init.dynamodb_users_arn}"
  dynamodb_users_stream_arn       = "${local.remote_init.dynamodb_users_stream_arn}"
  dynamodb_user_groups_name       = "${local.remote_init.dynamodb_user_groups_name}"
  dynamodb_user_groups_arn        = "${local.remote_init.dynamodb_user_groups_arn}"
  dynamodb_user_groups_stream_arn = "${local.remote_init.dynamodb_user_groups_stream_arn}"
  dynamodb_groups_name            = "${local.remote_init.dynamodb_groups_name}"
  dynamodb_groups_arn             = "${local.remote_init.dynamodb_groups_arn}"
  dynamodb_groups_stream_arn      = "${local.remote_init.dynamodb_groups_stream_arn}"
  dynamodb_words_name             = "${local.remote_init.dynamodb_words_name}"
  dynamodb_words_stream_arn       = "${local.remote_init.dynamodb_words_stream_arn}"
  dynamodb_history_name           = "${local.remote_init.dynamodb_history_name}"
  dynamodb_history_arn            = "${local.remote_init.dynamodb_history_arn}"
  dynamodb_history_stream_arn     = "${local.remote_init.dynamodb_history_stream_arn}"

  # -----------------------------------------------
  # API Gateway
  # -----------------------------------------------
  api_gateway_domain = "${aws_api_gateway_rest_api.this.id}.execute-api.${local.region}.amazonaws.com"

  api_endpoint_configuration = "EDGE"

  status_200       = { statusCode = 200 }
  response_version = { version = "${var.app_ver}" }

  # -----------------------------------------------
  # API Base Path Mappings
  # -----------------------------------------------
  rest_api_base_path = "cards"

  # -----------------------------------------------
  # Lambda Layers
  # -----------------------------------------------
  xray   = "${local.remote_layers.layers.xray}"
  moment = "${local.remote_layers.layers.moment}"
  lodash = "${local.remote_layers.layers.lodash}"
  axios  = "${local.remote_layers.layers.axios}"

  # -----------------------------------------------
  # Lambda
  # -----------------------------------------------
  alias_name         = "${local.environment}"
  lambda_handler     = "index.handler"
  lambda_runtime     = "nodejs10.x"
  audio_path_pattern = "audio"
}
