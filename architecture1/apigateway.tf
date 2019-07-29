# --------------------------------------------------------------------------------
# Amazon API Gateway
# --------------------------------------------------------------------------------
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
  depends_on = [
    "aws_api_gateway_rest_api.this",
    "aws_api_gateway_integration.this"
  ]

  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
}

resource "aws_api_gateway_stage" "this" {
  depends_on = ["aws_api_gateway_rest_api.this", "aws_api_gateway_deployment.this"]

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
resource "aws_api_gateway_method_settings" "this" {
  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
  stage_name  = "${aws_api_gateway_stage.this.stage_name}"
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }
}


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
  allow_method = "'OPTIONS,GET'"
}

# -------------------------------------------------------
# Amazon API Gateway Domain Name
# # -----------------------------------------------------
resource "aws_api_gateway_domain_name" "api" {
  domain_name     = "${var.custom_domain_api}"
  certificate_arn = "${var.certificate_arn}"

  endpoint_configuration {
    types = ["${local.api_endpoint_configuration}"]
  }
}

# -------------------------------------------------------
# Amazon API BASE PATH MAPPING
# # -----------------------------------------------------
resource "aws_api_gateway_base_path_mapping" "cards" {
  api_id      = "${aws_api_gateway_rest_api.this.id}"
  base_path   = "${local.rest_api_base_path}"
  stage_name  = "${aws_api_gateway_stage.this.stage_name}"
  domain_name = "${aws_api_gateway_domain_name.api.domain_name}"
}
