locals {
  # -----------------------------------------------
  # Project Informations
  # -----------------------------------------------
  remote_init = data.terraform_remote_state.initialize.outputs
  remote_unmu = data.terraform_remote_state.unmutable.outputs

  project_name        = local.remote_init.project_name
  project_name_uc     = local.remote_init.project_name_uc
  region              = data.aws_region.this.name
  account_id          = data.aws_caller_identity.this.account_id
  environment         = terraform.workspace
  is_dev              = local.environment == "dev"
  region_us           = "us-east-1"
  timezone            = "Asia/Tokyo"
  translation_url     = local.remote_init.translation_url
  translation_api_key = local.remote_init.ssm_param_translation_api_key
  ipa_url             = local.remote_init.ipa_url
  ipa_api_key         = local.remote_init.ssm_param_ipa_api_key
  parallelism         = "--parallelism=30"

  # -----------------------------------------------
  # API Gateway
  # -----------------------------------------------
  # api_base_path = "cards"
  api_gateway_files          = [filemd5("apigateway.tf")]
  api_gateway_deployment_md5 = base64encode(join("", local.api_gateway_files))
  http_method = {
    get    = "GET"
    post   = "POST"
    delete = "DELETE"
    put    = "PUT"
  }

  authorization_type_cognito = "COGNITO_USER_POOLS"

  # -----------------------------------------------
  # Cognito
  # -----------------------------------------------
  # identity_pool_arn = "${local.remote_main.identity_pool_arn}"
  # -----------------------------------------------
  # CodePipeline
  # -----------------------------------------------
  github_token = data.aws_ssm_parameter.github_token.value

  # -----------------------------------------------
  # CodeBuild
  # -----------------------------------------------
  build_type                 = "LINUX_CONTAINER"
  build_compute_type         = "BUILD_GENERAL1_SMALL"
  build_image                = "aws/codebuild/standard:2.0"
  github_repo_branch         = "master"
  github_organization        = local.remote_unmu.github_organization
  github_repo_backend        = local.remote_unmu.github_repo_backend
  github_repo_automation     = local.remote_unmu.github_repo_automation
  github_events              = local.is_dev ? "push" : "release"
  github_filter_json_path    = local.is_dev ? "$.ref" : "$.action"
  github_filter_match_equals = local.is_dev ? "refs/heads/master" : "published"

  # -----------------------------------------------
  # CodeDeploy
  # -----------------------------------------------
  backend_deployment_group = "BlueGreenGroup"

  # -----------------------------------------------
  # S3 Bucket
  # -----------------------------------------------
  bucket_name_audios    = local.remote_unmu.bucket_name_audios
  bucket_name_images    = local.remote_unmu.bucket_name_images
  bucket_name_logging   = local.remote_unmu.bucket_name_logging
  bucket_name_artifacts = local.remote_init.bucket_name_artifacts

  # -----------------------------------------------
  # API Gateway
  # -----------------------------------------------
  api_gateway_domain         = "${module.api.id}.execute-api.${local.region}.amazonaws.com"
  api_endpoint_configuration = "REGIONAL"

  status_200 = {
    statusCode = 200
  }
  response_version = {
    version = var.app_ver
  }

  deployment_files = [
    file("api_methods.tf"),
    file("api_resources.tf"),
    file("apigateway.tf"),
  ]

  # -----------------------------------------------
  # Cognito
  # -----------------------------------------------
  cognito_identity_pool_id = local.remote_unmu.cognito_identity_pool_id

  # -----------------------------------------------
  # Lambda Layers
  # -----------------------------------------------
  xray   = local.remote_init.layers.xray
  moment = local.remote_init.layers.moment
  lodash = local.remote_init.layers.lodash
  axios  = local.remote_init.layers.axios

  # -----------------------------------------------
  # Lambda
  # -----------------------------------------------
  lambda_api      = "arn:aws:apigateway:${local.region}:lambda:path/2015-03-31/functions"
  lambda_arn      = "arn:aws:lambda:${local.region}:${local.account_id}:function"
  lambda_api_arn  = "${local.lambda_api}/${local.lambda_arn}"
  lambda_function = local.project_name_uc
  lambda_alias_v1 = "v1"

  lambda = {
    a001 = {
      function_name = "${local.lambda_function}_A001"
      uri           = "${local.lambda_api_arn}:${local.lambda_function}_A001:${local.lambda_alias_v1}/invocations"
    }
    a002 = {
      function_name = "${local.lambda_function}_A002"
      uri           = "${local.lambda_api_arn}:${local.lambda_function}_A002:${local.lambda_alias_v1}/invocations"
    }
    a003 = {
      function_name = "${local.lambda_function}_A003"
      uri           = "${local.lambda_api_arn}:${local.lambda_function}_A003:${local.lambda_alias_v1}/invocations"
    }
    b001 = {
      function_name = "${local.lambda_function}_B001"
      uri           = "${local.lambda_api_arn}:${local.lambda_function}_B001:${local.lambda_alias_v1}/invocations"
    }
    b002 = {
      function_name = "${local.lambda_function}_B002"
      uri           = "${local.lambda_api_arn}:${local.lambda_function}_B002:${local.lambda_alias_v1}/invocations"
    }
    b003 = {
      function_name = "${local.lambda_function}_B003"
      uri           = "${local.lambda_api_arn}:${local.lambda_function}_B003:${local.lambda_alias_v1}/invocations"
    }
    b004 = {
      function_name = "${local.lambda_function}_B004"
      uri           = "${local.lambda_api_arn}:${local.lambda_function}_B004:${local.lambda_alias_v1}/invocations"
    }
    c001 = {
      function_name = "${local.lambda_function}_C001"
      uri           = "${local.lambda_api_arn}:${local.lambda_function}_C001:${local.lambda_alias_v1}/invocations"
    }
    c002 = {
      function_name = "${local.lambda_function}_C002"
      uri           = "${local.lambda_api_arn}:${local.lambda_function}_C002:${local.lambda_alias_v1}/invocations"
    }
    c003 = {
      function_name = "${local.lambda_function}_C003"
      uri           = "${local.lambda_api_arn}:${local.lambda_function}_C003:${local.lambda_alias_v1}/invocations"
    }
    c004 = {
      function_name = "${local.lambda_function}_C004"
      uri           = "${local.lambda_api_arn}:${local.lambda_function}_C004:${local.lambda_alias_v1}/invocations"
    }
    c006 = {
      function_name = "${local.lambda_function}_C006"
      uri           = "${local.lambda_api_arn}:${local.lambda_function}_C006:${local.lambda_alias_v1}/invocations"
    }
    c007 = {
      function_name = "${local.lambda_function}_C007"
      uri           = "${local.lambda_api_arn}:${local.lambda_function}_C007:${local.lambda_alias_v1}/invocations"
    }
    c008 = {
      function_name = "${local.lambda_function}_C008"
      uri           = "${local.lambda_api_arn}:${local.lambda_function}_C008:${local.lambda_alias_v1}/invocations"
    }
    d001 = {
      function_name = "${local.lambda_function}_D001"
      uri           = "${local.lambda_api_arn}:${local.lambda_function}_D001:${local.lambda_alias_v1}/invocations"
    }
    s001 = {
      function_name = "${local.lambda_function}_S001"
      uri           = "${local.lambda_api_arn}:${local.lambda_function}_S001}:${local.lambda_alias_v1}/invocations"
    }
  }

  deployment_group_names = [
    local.lambda.a001.function_name,
    local.lambda.a002.function_name,
    local.lambda.a003.function_name,
    local.lambda.b001.function_name,
    local.lambda.b002.function_name,
    local.lambda.b003.function_name,
    local.lambda.b004.function_name,
    local.lambda.c001.function_name,
    local.lambda.c002.function_name,
    local.lambda.c003.function_name,
    local.lambda.c004.function_name,
    local.lambda.c006.function_name,
    local.lambda.c007.function_name,
    local.lambda.c008.function_name,
    local.lambda.d001.function_name,
    local.lambda.s001.function_name,
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
  name = local.remote_init.domain_name
}

# -----------------------------------------------
# SSM Parameter Store - Github token
# -----------------------------------------------
data "aws_ssm_parameter" "github_token" {
  name = local.remote_init.ssm_param_github_token
}

# -----------------------------------------------
# AWS Account
# -----------------------------------------------
data "aws_caller_identity" "this" {}

