# -------------------------------------------------------
# Amazon API REST API
# -------------------------------------------------------
module "api" {
  source = "github.com/wwalpha/terraform-module-apigateway/api"

  api_name                   = "${local.project_name}"
  api_endpoint_configuration = "${local.api_endpoint_configuration}"
  cognito_user_pool_name     = "${local.remote_unmu.cognito_user_pool_name}"
  authorizer_name            = "CognitoAuthorizer"
  authorizer_type            = "COGNITO_USER_POOLS"
  # authorizer_role_name             = "${local.project_name_uc}_APIGateway_AuthorizerRole"
  # authorizer_policy                = "${file("iam/apigateway_policy_authorizer.json")}"
  authorizer_result_ttl_in_seconds = 0
}

# -------------------------------------------------------
# Amazon API Deployment
# -------------------------------------------------------
module "deployment" {
  source = "github.com/wwalpha/terraform-module-apigateway/deployment"

  rest_api_id                            = "${module.api.id}"
  stage_name                             = "v1"
  custom_domain_name                     = "${aws_acm_certificate.api.domain_name}"
  custom_domain_regional_certificate_arn = "${aws_acm_certificate_validation.api.certificate_arn}"
  custom_domain_endpoint_configuration   = "${local.api_endpoint_configuration}"

  integration_ids = [
    "${module.m001.integration_id}",
    "${module.m002.integration_id}",
    "${module.m003.integration_id}",
    "${module.m004.integration_id}",
    "${module.m005.integration_id}",
    "${module.m006.integration_id}",
    "${module.m007.integration_id}",
    "${module.m008.integration_id}",
    "${module.m009.integration_id}",
    "${module.m010.integration_id}",
    "${module.m011.integration_id}",
    "${module.m012.integration_id}",
    "${module.m013.integration_id}",
  ]

  deployment_md5 = "${base64encode(join("", local.deployment_files))}"
}

# --------------------------------------------------------------------------------
# Amazon API Gateway Usage Plan
# --------------------------------------------------------------------------------
# resource "aws_api_gateway_usage_plan" "usage_plan" {
#   name = "ipa_usage_plan"

#   api_stages {
#     api_id = "${aws_api_gateway_rest_api.ipa_api.id}"
#     stage  = "${aws_api_gateway_deployment.api_deployment.stage_name}"
#   }

#   quota_settings {
#     limit  = 200
#     period = "DAY"
#   }

#   throttle_settings {
#     burst_limit = 5
#     rate_limit  = 5
#   }
# }

# resource "aws_api_gateway_api_key" "api_key" {
#   name = "ipa_api_key"
# }

# resource "aws_api_gateway_usage_plan_key" "usage_plan_key" {
#   key_id        = "${aws_api_gateway_api_key.api_key.id}"
#   key_type      = "API_KEY"
#   usage_plan_id = "${aws_api_gateway_usage_plan.usage_plan.id}"
# }
# resource "aws_api_gateway_method_settings" "this" {
#   rest_api_id = "${aws_api_gateway_rest_api.this.id}"
#   stage_name  = "${aws_api_gateway_stage.this.stage_name}"
#   method_path = "*/*"

#   settings {
#     metrics_enabled = false
#     logging_level   = "INFO"
#   }
# }

# -------------------------------------------------------
# Amazon API Method
# -------------------------------------------------------
module "version" {
  source = "github.com/wwalpha/terraform-module-apigateway/method"

  rest_api_id        = "${module.api.id}"
  resource_id        = "${module.api.root_resource_id}"
  http_method        = "GET"
  integration_type   = "MOCK"
  response_templates = "${jsonencode(local.response_version)}"
}

# -------------------------------------------------------
# Amazon API CORS
# -------------------------------------------------------
# module "CORS_ROOT" {
#   source = "github.com/wwalpha/terraform-module-registry/aws/api-cors"

#   rest_api_id = "${aws_api_gateway_rest_api.this.id}"
#   resource_id = "${aws_api_gateway_rest_api.this.root_resource_id}"

#   allow_origin = "${var.cors_allow_origin}"
#   allow_method = "'GET,OPTIONS'"
# }
