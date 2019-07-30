resource "aws_api_gateway_resource" "users" {
  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
  parent_id   = "${aws_api_gateway_rest_api.this.root_resource_id}"
  path_part   = "users"
}

# --------------------------------------------------------------------------------
# ユーザ情報取得: GET /users/{userId}
# --------------------------------------------------------------------------------
module "A001" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-lambda"

  project_name         = "${local.project_name_uc}"
  region               = "${local.region}"
  rest_api_id          = "${aws_api_gateway_rest_api.this.id}"
  http_method          = "GET"
  method_parent_id     = "${aws_api_gateway_resource.users.id}"
  method_parent_path   = "${aws_api_gateway_resource.users.path}"
  method_authorization = "AWS_IAM"
  method_path_part     = "{userId}"

  lambda_function_name = "A001"
  lambda_handler       = "${local.lambda_handler}"
  lambda_runtime       = "${local.lambda_runtime}"
  lambda_envs = {
    TZ = "${local.timezone}"
  }
  lambda_log_retention_in_days = "${var.lambda_log_retention_in_days}"
  lambda_role_policy_json      = ["${data.aws_iam_policy_document.dynamodb_access_policy.json}"]

  lambda_layers = ["${local.xray}"]
}

module "CORS_A001" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-cors"

  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
  resource_id = "${module.A001.resource_id}"

  allow_origin = "${var.cors_allow_origin}"
  allow_method = "'OPTIONS,GET'"
}


# --------------------------------------------------------------------------------
# ユーザ履歴集計取得: GET /users/{userId}/history
# --------------------------------------------------------------------------------
module "A002" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-lambda"

  project_name         = "${local.project_name_uc}"
  region               = "${local.region}"
  rest_api_id          = "${aws_api_gateway_rest_api.this.id}"
  http_method          = "GET"
  method_parent_id     = "${module.A001.resource_id}"
  method_parent_path   = "${module.A001.resource_path}"
  method_authorization = "AWS_IAM"
  method_path_part     = "history"

  lambda_function_name         = "A002"
  lambda_handler               = "${local.lambda_handler}"
  lambda_runtime               = "${local.lambda_runtime}"
  lambda_memory_size           = 512
  lambda_log_retention_in_days = "${var.lambda_log_retention_in_days}"
  lambda_role_policy_json      = ["${data.aws_iam_policy_document.dynamodb_access_policy.json}"]
  lambda_envs = {
    TABLE_HISTORY     = "${local.dynamodb_history_name}"
    TABLE_USER_GROUPS = "${local.dynamodb_user_groups_name}"
    TABLE_GROUP_WORDS = "${local.dynamodb_group_words_name}"
    TZ                = "${local.timezone}"
  }

  lambda_layers = ["${local.xray}", "${local.moment}", "${local.lodash}"]
}

module "CORS_A002" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-cors"

  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
  resource_id = "${module.A002.resource_id}"

  allow_origin = "${var.cors_allow_origin}"
  allow_method = "'OPTIONS,GET'"
}

module "A003" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-lambda"

  project_name         = "${local.project_name_uc}"
  region               = "${local.region}"
  rest_api_id          = "${aws_api_gateway_rest_api.this.id}"
  http_method          = "POST"
  method_parent_id     = "${module.A001.resource_id}"
  method_parent_path   = "${module.A001.resource_path}"
  method_authorization = "AWS_IAM"
  method_path_part     = "fixdelay"

  lambda_function_name         = "A003"
  lambda_handler               = "${local.lambda_handler}"
  lambda_memory_size           = 512
  lambda_runtime               = "${local.lambda_runtime}"
  lambda_timeout               = 90
  lambda_log_retention_in_days = "${var.lambda_log_retention_in_days}"
  lambda_layers                = ["${local.xray}", "${local.moment}"]

  lambda_envs = {
    TABLE_USERS       = "${local.dynamodb_users_name}"
    TABLE_USER_GROUPS = "${local.dynamodb_user_groups_name}"
    TABLE_GROUP_WORDS = "${local.dynamodb_group_words_name}"
    TZ                = "${local.timezone}"
  }
  lambda_role_policy_json = [
    "${data.aws_iam_policy_document.dynamodb_access_policy.json}",
    "${data.aws_iam_policy_document.dynamodb_update.json}"
  ]
}

module "CORS_A003" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-cors"

  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
  resource_id = "${module.A003.resource_id}"

  allow_origin = "${var.cors_allow_origin}"
  allow_method = "'OPTIONS,POST'"
}
