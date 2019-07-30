locals {
  # -----------------------------------------------
  # Project Informations
  # -----------------------------------------------
  remote_init = "${data.terraform_remote_state.initialize.outputs}"
  remote_unmu = "${data.terraform_remote_state.unmutable.outputs}"

  project_name        = "${local.remote_init.project_name}"
  project_name_uc     = "${local.remote_init.project_name_uc}"
  environment         = "${terraform.workspace}"
  region              = "${data.aws_region.current.name}"
  region_us           = "us-east-1"
  timezone            = "${var.timezone}"
  translation_url     = "${local.remote_init.translation_url}"
  translation_api_key = "${local.remote_init.ssm_param_translation_api_key}"
  ipa_url             = "${local.remote_init.ipa_url}"
  ipa_api_key         = "${local.remote_init.ssm_param_ipa_api_key}"


  # -----------------------------------------------
  # CloudFront
  # -----------------------------------------------
  origin_id_web          = "web"
  origin_id_audio        = "audio"
  origin_id_api          = "api"
  origin_id_path         = "/cards"
  default_root_object    = "index.html"
  viewer_protocol_policy = "redirect-to-https"
  logging_prefix         = "web"
  audio_path_pattern     = "${local.origin_id_audio}"

  # -----------------------------------------------
  # CloudTrail
  # -----------------------------------------------
  ct_prefix = "trail"

  # -----------------------------------------------
  # S3 Bucket
  # -----------------------------------------------
  frontend_bucket_name                 = "${local.remote_unmu.frontend_bucket_name}"
  frontend_bucket_arn                  = "${local.remote_unmu.frontend_bucket_arn}"
  frontend_bucket_regional_domain_name = "${local.remote_unmu.frontend_bucket_regional_domain_name}"
  audios_bucket_name                   = "${local.remote_unmu.audios_bucket_name}"
  audios_bucket_arn                    = "${local.remote_unmu.audios_bucket_arn}"
  audios_bucket_regional_domain_name   = "${local.remote_unmu.audios_bucket_regional_domain_name}"
  logging_bucket_name                  = "${local.remote_unmu.logging_bucket_name}"
  logging_bucket_arn                   = "${local.remote_unmu.logging_bucket_arn}"
  logging_bucket_regional_domain_name  = "${local.remote_unmu.logging_bucket_regional_domain_name}"

  # -----------------------------------------------
  # DynamoDB
  # -----------------------------------------------
  dynamodb_users_name             = "${local.remote_init.dynamodb_users_name}"
  dynamodb_users_arn              = "${local.remote_init.dynamodb_users_arn}"
  dynamodb_users_stream_arn       = "${local.remote_init.dynamodb_users_stream_arn}"
  dynamodb_user_groups_name       = "${local.remote_init.dynamodb_user_groups_name}"
  dynamodb_user_groups_arn        = "${local.remote_init.dynamodb_user_groups_arn}"
  dynamodb_user_groups_stream_arn = "${local.remote_init.dynamodb_user_groups_stream_arn}"
  dynamodb_group_words_name       = "${local.remote_unmu.dynamodb_group_words_name}"
  dynamodb_group_words_arn        = "${local.remote_unmu.dynamodb_group_words_arn}"
  dynamodb_group_words_stream_arn = "${local.remote_unmu.dynamodb_group_words_stream_arn}"
  dynamodb_words_name             = "${local.remote_init.dynamodb_words_name}"
  dynamodb_words_stream_arn       = "${local.remote_init.dynamodb_words_stream_arn}"
  dynamodb_history_name           = "${local.remote_init.dynamodb_history_name}"
  dynamodb_history_arn            = "${local.remote_init.dynamodb_history_arn}"
  dynamodb_history_stream_arn     = "${local.remote_init.dynamodb_history_stream_arn}"

  # -----------------------------------------------
  # API Gateway
  # -----------------------------------------------
  # rest_api_id            = "${local.remote_api.rest_api_id}"
  # rest_api_execution_arn = "${local.remote_api.rest_api_execution_arn}"
  # api_gateway_domain     = "${local.rest_api_id}.execute-api.${local.region}.amazonaws.com"

  # -----------------------------------------------
  # Route53
  # -----------------------------------------------
  route53_ttl       = "300"
  record_type_cname = "CNAME"

  # -----------------------------------------------
  # Lambda Layers
  # -----------------------------------------------
  xray   = "${local.remote_unmu.layers.xray}"
  moment = "${local.remote_unmu.layers.moment}"
  lodash = "${local.remote_unmu.layers.lodash}"
  axios  = "${local.remote_unmu.layers.axios}"

  # -----------------------------------------------
  # Lambda 
  # -----------------------------------------------
  alias_name     = "${local.environment}"
  lambda_handler = "index.handler"
  lambda_runtime = "nodejs10.x"
}
