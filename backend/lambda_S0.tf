module "s001" {
  source                = "github.com/wwalpha/terraform-module-registry/aws/lambda"
  dummy_enabled         = true
  publish               = true
  function_name         = "${local.lambda.s001.function_name}"
  alias_name            = "${local.lambda_alias_name}"
  handler               = "${local.lambda_handler}"
  runtime               = "${local.lambda_runtime}"
  role_name             = "${local.lambda.s001.role_name}"
  log_retention_in_days = "${var.lambda_log_retention_in_days}"
  timeout               = 5
  trigger_principal     = "apigateway.amazonaws.com"
  trigger_source_arn    = "${module.api.execution_arn}/*/*/*"

  role_policy_json = [
    "${file("iam/lambda_policy_dynamodb.json")}",
  ]
}
