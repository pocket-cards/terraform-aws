# -------------------------------------------------------
# Amazon API Gateway
# # -----------------------------------------------------
resource "aws_api_gateway_rest_api" "this" {
  name = "${local.project_name}"

  endpoint_configuration {
    types = ["${local.api_endpoint_configuration}"]
  }
}

# -------------------------------------------------------
# Amazon API Gateway Deployment
# # -----------------------------------------------------
resource "aws_api_gateway_deployment" "this" {
  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
  variables = {
    deployment_md5 = "${local.api_gateway_deployment_md5}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# -------------------------------------------------------
# Amazon API Gateway Stage
# # -----------------------------------------------------
resource "aws_api_gateway_stage" "this" {
  stage_name    = "v1"
  rest_api_id   = "${aws_api_gateway_rest_api.this.id}"
  deployment_id = "${aws_api_gateway_deployment.this.id}"

  xray_tracing_enabled = true
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


resource "aws_api_gateway_method" "version" {
  depends_on = ["aws_api_gateway_rest_api.this"]

  rest_api_id   = "${aws_api_gateway_rest_api.this.id}"
  resource_id   = "${aws_api_gateway_rest_api.this.root_resource_id}"
  http_method   = "GET"
  authorization = "NONE"

  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_api_gateway_integration" "this" {
  depends_on = ["aws_api_gateway_method.version"]

  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
  resource_id = "${aws_api_gateway_rest_api.this.root_resource_id}"
  http_method = "${aws_api_gateway_method.version.http_method}"
  type        = "MOCK"

  request_templates = {
    "application/json" = "${jsonencode(local.status_200)}"
  }
}

resource "aws_api_gateway_method_response" "version" {
  depends_on = ["aws_api_gateway_method.version"]

  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
  resource_id = "${aws_api_gateway_rest_api.this.root_resource_id}"
  http_method = "${aws_api_gateway_method.version.http_method}"
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "version" {
  depends_on = ["aws_api_gateway_method.version", "aws_api_gateway_method_response.version"]

  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
  resource_id = "${aws_api_gateway_rest_api.this.root_resource_id}"
  http_method = "${aws_api_gateway_method.version.http_method}"
  status_code = "${aws_api_gateway_method_response.version.status_code}"

  response_templates = {
    "application/json" = "${jsonencode(local.response_version)}"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "${var.cors_allow_origin}"
  }
}

module "CORS_ROOT" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-cors"

  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
  resource_id = "${aws_api_gateway_rest_api.this.root_resource_id}"

  allow_origin = "${var.cors_allow_origin}"
  allow_method = "'GET,OPTIONS'"
}

# -------------------------------------------------------
# Amazon API Gateway Domain Name
# # -----------------------------------------------------
resource "aws_api_gateway_domain_name" "this" {
  domain_name              = "${aws_acm_certificate.api.domain_name}"
  regional_certificate_arn = "${aws_acm_certificate_validation.api.certificate_arn}"

  endpoint_configuration {
    types = ["${local.api_endpoint_configuration}"]
  }
}

# -------------------------------------------------------
# AWS Route53 - API Gateway Record
# # -----------------------------------------------------
resource "aws_route53_record" "apigateway" {
  name    = "${aws_api_gateway_domain_name.this.domain_name}"
  type    = "A"
  zone_id = "${data.aws_route53_zone.this.id}"

  alias {
    evaluate_target_health = true
    name                   = "${aws_api_gateway_domain_name.this.regional_domain_name}"
    zone_id                = "${aws_api_gateway_domain_name.this.regional_zone_id}"
  }
}

# -------------------------------------------------------
# Amazon API BASE PATH MAPPING
# -------------------------------------------------------
resource "aws_api_gateway_base_path_mapping" "cards" {
  api_id = "${aws_api_gateway_rest_api.this.id}"
  # base_path   = "${local.rest_api_base_path}"
  stage_name  = "${aws_api_gateway_stage.this.stage_name}"
  domain_name = "${aws_api_gateway_domain_name.this.domain_name}"
}

# -------------------------------------------------------
# Amazon API Gateway Authorizer
# -------------------------------------------------------
resource "aws_api_gateway_authorizer" "this" {
  name          = "CognitoAuthorizer"
  type          = "COGNITO_USER_POOLS"
  rest_api_id   = "${aws_api_gateway_rest_api.this.id}"
  provider_arns = "${data.aws_cognito_user_pools.this.arns}"
}

# -------------------------------------------------------
# Amazon API Gateway Authorizer Role
# -------------------------------------------------------
resource "aws_iam_role" "api_authorizer" {
  name = "${local.project_name_uc}_APIGateway_AuthorizerRole"
  path = "/"

  assume_role_policy = "${file("iam/apigateway_principals.json")}"
}

# -------------------------------------------------------
# Amazon API Gateway Authorizer Policy
# -------------------------------------------------------
resource "aws_iam_role_policy" "api_authorizer" {
  name = "api_authorizer"
  role = "${aws_iam_role.api_authorizer.id}"

  policy = "${file("iam/apigateway_policy_authorizer.json")}"
}
