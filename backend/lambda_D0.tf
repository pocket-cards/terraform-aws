# -----------------------------------------------
# 画像から単語に変換する: /image2text
# -----------------------------------------------
module "D001" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-lambda"
  # source               = "./terraform-modules-api-lambda"
  project_name         = "${local.project_name_uc}"
  region               = "${local.region}"
  rest_api_id          = "${aws_api_gateway_rest_api.this.id}"
  http_method          = "POST"
  method_parent_id     = "${aws_api_gateway_rest_api.this.root_resource_id}"
  method_parent_path   = "/"
  method_authorization = "COGNITO_USER_POOLS"
  method_authorizer_id = "${aws_api_gateway_authorizer.this.id}"
  method_path_part     = "image2text"

  lambda_publish       = true
  lambda_function_name = "${local.lambda.D001.function_name}"
  lambda_alias_name    = "${local.lambda_alias_name}"
  lambda_handler       = "${local.lambda_handler}"
  lambda_runtime       = "${local.lambda_runtime}"
  lambda_role_name     = "${local.lambda.D001.role_name}"
  lambda_memory_size   = 1024
  lambda_envs = {
    EXCLUDE_WORD = "",
    IMAGE_BUCKET = "${local.bucket_name_images}"
    TZ           = "${local.timezone}"
  }

  lambda_log_retention_in_days = "${var.lambda_log_retention_in_days}"
  lambda_role_policy_json = [
    "${data.aws_iam_policy_document.s3_access_policy.json}",
    "${data.aws_iam_policy_document.rekognition.json}"
  ]

  lambda_layers = ["${local.xray}", "${local.moment}"]
}

module "CORS_D001" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-cors"

  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
  resource_id = "${module.D001.resource_id}"

  allow_origin = "${var.cors_allow_origin}"
  allow_method = "'POST,OPTIONS'"
}
