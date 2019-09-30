# module "S001" {
#   source = "github.com/wwalpha/terraform-module-registry/aws/lambda"

#   enable_dummy          = true
#   enable_xray           = true
#   publish               = true
#   function_name         = "${local.lambda.S001.function_name}"
#   alias_name            = "${local.lambda_alias_name}"
#   handler               = "${local.lambda_handler}"
#   runtime               = "${local.lambda_runtime}"
#   role_name             = "${local.lambda.S001.role_name}"
#   layers                = ["${local.xray}", "${local.moment}"]
#   log_retention_in_days = "${var.lambda_log_retention_in_days}"
#   timeout               = 5
#   # trigger_principal     = "dynamodb.amazonaws.com"
#   # trigger_source_arn    = "${local.dynamodb_group_words_arn}"

#   role_policy_json = [
#     "${data.aws_iam_policy_document.dynamodb_access_policy.json}",
#     "${data.aws_iam_policy_document.dynamodb_stream.json}"
#   ]
# }

module "S001" {
  source = "github.com/wwalpha/terraform-module-registry/aws/lambda"

  enable_dummy          = true
  enable_xray           = true
  publish               = true
  function_name         = "${local.lambda.S001.function_name}"
  alias_name            = "${local.lambda_alias_name}"
  handler               = "${local.lambda_handler}"
  runtime               = "${local.lambda_runtime}"
  role_name             = "${local.lambda.S001.role_name}"
  log_retention_in_days = "${var.lambda_log_retention_in_days}"
  timeout               = 5
  trigger_principal     = "apigateway.amazonaws.com"
  trigger_source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/*/*"

  role_policy_json = [
    "${data.aws_iam_policy_document.dynamodb_access_policy.json}",
  ]
}
