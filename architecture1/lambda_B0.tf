
# -----------------------------------------------
# グループ登録: /groups
# -----------------------------------------------
module "B001" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-lambda"
  # source               = "./terraform-modules-api-lambda"
  project_name         = "${local.project_name_uc}"
  region               = "${local.region}"
  rest_api_id          = "${aws_api_gateway_rest_api.this.id}"
  http_method          = "POST"
  method_parent_id     = "${aws_api_gateway_rest_api.this.root_resource_id}"
  method_parent_path   = "/"
  method_authorization = "AWS_IAM"
  method_path_part     = "groups"

  lambda_function_name = "B001"
  lambda_handler       = "${local.lambda_handler}"
  lambda_runtime       = "${local.lambda_runtime}"
  lambda_envs = {
    Name = "B001"
  }
  lambda_log_retention_in_days = "${var.lambda_log_retention_in_days}"
  lambda_role_policy_json      = ["${data.aws_iam_policy_document.dynamodb_access_policy.json}"]
}

module "CORS_B001" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-cors"

  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
  resource_id = "${module.B001.resource_id}"

  allow_origin = "${var.cors_allow_origin}"
  allow_method = "'POST,OPTIONS'"
}

# -----------------------------------------------
# グループ情報取得: /groups/{groupId}
# -----------------------------------------------
module "B002" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-lambda"
  # source             = "./terraform-modules-api-lambda"
  project_name       = "${local.project_name_uc}"
  region             = "${local.region}"
  rest_api_id        = "${aws_api_gateway_rest_api.this.id}"
  http_method        = "GET"
  method_parent_id   = "${module.B001.resource_id}"
  method_parent_path = "${module.B001.resource_path}"

  method_authorization = "AWS_IAM"
  method_path_part     = "{groupId}"

  lambda_function_name = "B002"
  lambda_handler       = "${local.lambda_handler}"
  lambda_runtime       = "${local.lambda_runtime}"
  lambda_envs = {
    Name = "B002"
  }
  lambda_log_retention_in_days = "${var.lambda_log_retention_in_days}"
  lambda_role_policy_json      = ["${data.aws_iam_policy_document.dynamodb_access_policy.json}"]
}

module "CORS_B002" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-cors"

  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
  resource_id = "${module.B002.resource_id}"

  allow_origin = "${var.cors_allow_origin}"
  allow_method = "'GET,PUT,DELETE,OPTIONS'"
}

# -----------------------------------------------
# グループ情報変更: /groups/{groupId}
# -----------------------------------------------
module "B003" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-lambda"
  # source               = "./terraform-modules-api-lambda"
  project_name         = "${local.project_name_uc}"
  region               = "${local.region}"
  rest_api_id          = "${aws_api_gateway_rest_api.this.id}"
  http_method          = "PUT"
  method_parent_id     = "${module.B002.resource_id}"
  method_parent_path   = "${module.B002.resource_path}"
  method_authorization = "AWS_IAM"

  lambda_function_name = "B003"
  lambda_handler       = "${local.lambda_handler}"
  lambda_runtime       = "${local.lambda_runtime}"
  lambda_envs = {
    Name = "B003"
  }
  lambda_log_retention_in_days = "${var.lambda_log_retention_in_days}"
  lambda_role_policy_json      = ["${data.aws_iam_policy_document.dynamodb_access_policy.json}"]
}

# -----------------------------------------------
# グループ情報削除: /groups/{groupId}
# -----------------------------------------------
module "B004" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-lambda"
  # source               = "./terraform-modules-api-lambda"
  project_name         = "${local.project_name_uc}"
  region               = "${local.region}"
  rest_api_id          = "${aws_api_gateway_rest_api.this.id}"
  http_method          = "DELETE"
  method_parent_id     = "${module.B002.resource_id}"
  method_parent_path   = "${module.B002.resource_path}"
  method_authorization = "AWS_IAM"

  lambda_function_name = "B004"
  lambda_handler       = "${local.lambda_handler}"
  lambda_runtime       = "${local.lambda_runtime}"
  lambda_envs = {
    Name = "B004"
  }
  lambda_log_retention_in_days = "${var.lambda_log_retention_in_days}"
  lambda_role_policy_json      = ["${data.aws_iam_policy_document.dynamodb_access_policy.json}"]
}
