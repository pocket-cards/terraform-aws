

# -----------------------------------------------
# 単語一括登録: /groups/{groupId}/words
# -----------------------------------------------
module "C001" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-lambda"
  # source               = "./terraform-modules-api-lambda"
  project_name         = "${local.project_name_uc}"
  region               = "${local.region}"
  rest_api_id          = "${aws_api_gateway_rest_api.this.id}"
  http_method          = "POST"
  method_parent_id     = "${module.B002.resource_id}"
  method_parent_path   = "${module.B002.resource_path}"
  method_authorization = "CUSTOM"
  method_path_part     = "words"

  lambda_function_name = "${local.lambda.C001.function_name}"
  lambda_alias_name    = "${local.lambda_alias_name}"
  lambda_handler       = "${local.lambda_handler}"
  lambda_runtime       = "${local.lambda_runtime}"
  lambda_role_name     = "${local.lambda.C001.role_name}"
  lambda_memory_size   = 1024
  lambda_envs = {
    TABLE_WORDS         = "${local.dynamodb_name_words}"
    TABLE_GROUP_WORDS   = "${local.dynamodb_name_group_words}"
    IPA_URL             = "${local.ipa_url}"
    IPA_API_KEY         = "${local.ipa_api_key}"
    MP3_BUCKET          = "${local.bucket_name_audios}"
    PATH_PATTERN        = "${local.audio_path_pattern}"
    TRANSLATION_URL     = "${local.translation_url}"
    TRANSLATION_API_KEY = "${local.translation_api_key}"
    TZ                  = "${local.timezone}"
  }

  lambda_log_retention_in_days = "${var.lambda_log_retention_in_days}"
  lambda_role_policy_json = [
    "${data.aws_iam_policy_document.dynamodb_access_policy.json}",
    "${data.aws_iam_policy_document.s3_access_policy.json}",
    "${data.aws_iam_policy_document.polly.json}",
    "${data.aws_iam_policy_document.ssm_policy.json}"
  ]

  lambda_layers = ["${local.xray}", "${local.axios}", "${local.moment}"]
}

module "CORS_C001" {
  # source = "./terraform-modules-api-cors"
  source = "github.com/wwalpha/terraform-module-registry/aws/api-cors"

  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
  resource_id = "${module.C001.resource_id}"

  allow_origin = "${var.cors_allow_origin}"
  allow_method = "'GET,POST,OPTIONS,POST'"
}

# -----------------------------------------------
# 単語一覧取得: /groups/{groupId}/words
# -----------------------------------------------
module "C002" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-lambda"

  project_name         = "${local.project_name_uc}"
  region               = "${local.region}"
  rest_api_id          = "${aws_api_gateway_rest_api.this.id}"
  http_method          = "GET"
  method_parent_id     = "${module.C001.resource_id}"
  method_parent_path   = "${module.C001.resource_path}"
  method_authorization = "CUSTOM"

  lambda_function_name = "${local.lambda.C002.function_name}"
  lambda_alias_name    = "${local.lambda_alias_name}"
  lambda_handler       = "${local.lambda_handler}"
  lambda_runtime       = "${local.lambda_runtime}"
  lambda_role_name     = "${local.lambda.C002.role_name}"
  lambda_envs = {
    TZ = "${local.timezone}"
  }
  lambda_log_retention_in_days = "${var.lambda_log_retention_in_days}"
  lambda_role_policy_json      = ["${data.aws_iam_policy_document.dynamodb_access_policy.json}"]

  lambda_layers = ["${local.xray}"]
}


# -----------------------------------------------
# 単語情報取得: /groups/{groupId}/words/{word} 
# -----------------------------------------------
module "C003" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-lambda"
  # source               = "./terraform-modules-api-lambda"
  project_name         = "${local.project_name_uc}"
  region               = "${local.region}"
  rest_api_id          = "${aws_api_gateway_rest_api.this.id}"
  http_method          = "GET"
  method_parent_id     = "${module.C001.resource_id}"
  method_parent_path   = "${module.C001.resource_path}"
  method_authorization = "CUSTOM"
  method_path_part     = "{word}"

  lambda_function_name = "${local.lambda.C003.function_name}"
  lambda_alias_name    = "${local.lambda_alias_name}"
  lambda_handler       = "${local.lambda_handler}"
  lambda_runtime       = "${local.lambda_runtime}"
  lambda_role_name     = "${local.lambda.C003.role_name}"
  lambda_envs = {
    TZ = "${local.timezone}"
  }
  lambda_log_retention_in_days = "${var.lambda_log_retention_in_days}"
  lambda_role_policy_json      = ["${data.aws_iam_policy_document.dynamodb_access_policy.json}"]

  lambda_layers = ["${local.xray}"]

}

module "CORS_001" {
  # source = "./terraform-modules-api-cors"
  source = "github.com/wwalpha/terraform-module-registry/aws/api-cors"

  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
  resource_id = "${module.C003.resource_id}"

  allow_origin = "${var.cors_allow_origin}"
  allow_method = "'GET,PUT,OPTIONS'"
}

# -----------------------------------------------
# 単語情報更新: /groups/{groupId}/words/{word} 
# -----------------------------------------------
module "C004" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-lambda"
  # source               = "./terraform-modules-api-lambda"
  project_name         = "${local.project_name_uc}"
  region               = "${local.region}"
  rest_api_id          = "${aws_api_gateway_rest_api.this.id}"
  http_method          = "PUT"
  method_parent_id     = "${module.C003.resource_id}"
  method_parent_path   = "${module.C003.resource_path}"
  method_authorization = "CUSTOM"

  lambda_function_name         = "${local.lambda.C004.function_name}"
  lambda_alias_name            = "${local.lambda_alias_name}"
  lambda_handler               = "${local.lambda_handler}"
  lambda_runtime               = "${local.lambda_runtime}"
  lambda_role_name             = "${local.lambda.C004.role_name}"
  lambda_layers                = ["${local.xray}", "${local.moment}"]
  lambda_log_retention_in_days = "${var.lambda_log_retention_in_days}"
  lambda_role_policy_json      = ["${data.aws_iam_policy_document.dynamodb_access_policy.json}"]

  lambda_envs = {
    TABLE_GROUP_WORDS = "${local.dynamodb_name_group_words}"
    TABLE_HISTORY     = "${local.dynamodb_name_history}"
    TABLE_USER_GROUPS = "${local.dynamodb_name_user_groups}"
    TZ                = "${local.timezone}"
  }
}

# -----------------------------------------------
# 新規学習モード単語一覧: /groups/{groupId}/new
# -----------------------------------------------
module "C006" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-lambda"

  project_name         = "${local.project_name_uc}"
  region               = "${local.region}"
  rest_api_id          = "${aws_api_gateway_rest_api.this.id}"
  http_method          = "GET"
  method_parent_id     = "${module.B002.resource_id}"
  method_parent_path   = "${module.B002.resource_path}"
  method_authorization = "CUSTOM"
  method_path_part     = "new"

  lambda_function_name         = "${local.lambda.C006.function_name}"
  lambda_alias_name            = "${local.lambda_alias_name}"
  lambda_handler               = "${local.lambda_handler}"
  lambda_runtime               = "${local.lambda_runtime}"
  lambda_role_name             = "${local.lambda.C006.role_name}"
  lambda_memory_size           = 512
  lambda_log_retention_in_days = "${var.lambda_log_retention_in_days}"
  lambda_role_policy_json      = ["${data.aws_iam_policy_document.dynamodb_access_policy.json}"]

  lambda_envs = {
    WORDS_LIMIT       = 10
    TABLE_WORDS       = "${local.dynamodb_name_words}"
    TABLE_GROUP_WORDS = "${local.dynamodb_name_group_words}"
    TZ                = "${local.timezone}"
  }

  lambda_layers = ["${local.xray}", "${local.moment}"]
}


module "CORS_C006" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-cors"

  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
  resource_id = "${module.C006.resource_id}"

  allow_origin = "${var.cors_allow_origin}"
  allow_method = "'GET,OPTIONS'"
}

# -----------------------------------------------
# 新規学習モード単語一覧: /groups/{groupId}/test
# -----------------------------------------------
module "C007" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-lambda"

  project_name         = "${local.project_name_uc}"
  region               = "${local.region}"
  rest_api_id          = "${aws_api_gateway_rest_api.this.id}"
  http_method          = "GET"
  method_parent_id     = "${module.B002.resource_id}"
  method_parent_path   = "${module.B002.resource_path}"
  method_authorization = "CUSTOM"
  method_path_part     = "test"

  lambda_function_name         = "${local.lambda.C007.function_name}"
  lambda_alias_name            = "${local.lambda_alias_name}"
  lambda_handler               = "${local.lambda_handler}"
  lambda_runtime               = "${local.lambda_runtime}"
  lambda_role_name             = "${local.lambda.C007.role_name}"
  lambda_log_retention_in_days = "${var.lambda_log_retention_in_days}"
  lambda_role_policy_json      = ["${data.aws_iam_policy_document.dynamodb_access_policy.json}"]
  lambda_layers                = ["${local.xray}", "${local.moment}"]

  lambda_envs = {
    WORDS_LIMIT       = 10
    TABLE_WORDS       = "${local.dynamodb_name_words}"
    TABLE_GROUP_WORDS = "${local.dynamodb_name_group_words}"
    TZ                = "${local.timezone}"
  }
}

module "CORS_C007" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-cors"

  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
  resource_id = "${module.C007.resource_id}"

  allow_origin = "${var.cors_allow_origin}"
  allow_method = "'GET,OPTIONS'"
}
# -----------------------------------------------
# 新規学習モード単語一覧: /groups/{groupId}/review
# -----------------------------------------------
module "C008" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-lambda"
  # source               = "./terraform-modules-api-lambda"
  project_name         = "${local.project_name_uc}"
  region               = "${local.region}"
  rest_api_id          = "${aws_api_gateway_rest_api.this.id}"
  http_method          = "GET"
  method_parent_id     = "${module.B002.resource_id}"
  method_parent_path   = "${module.B002.resource_path}"
  method_authorization = "CUSTOM"
  method_path_part     = "review"

  lambda_function_name         = "${local.lambda.C008.function_name}"
  lambda_alias_name            = "${local.lambda_alias_name}"
  lambda_handler               = "${local.lambda_handler}"
  lambda_runtime               = "${local.lambda_runtime}"
  lambda_role_name             = "${local.lambda.C008.role_name}"
  lambda_log_retention_in_days = "${var.lambda_log_retention_in_days}"
  lambda_role_policy_json      = ["${data.aws_iam_policy_document.dynamodb_access_policy.json}"]
  lambda_layers                = ["${local.xray}"]

  lambda_envs = {
    WORDS_LIMIT       = 10
    TABLE_WORDS       = "${local.dynamodb_name_words}"
    TABLE_GROUP_WORDS = "${local.dynamodb_name_group_words}"
    TZ                = "${local.timezone}"
  }
}

module "CORS_C008" {
  source = "github.com/wwalpha/terraform-module-registry/aws/api-cors"

  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
  resource_id = "${module.C008.resource_id}"

  allow_origin = "${var.cors_allow_origin}"
  allow_method = "'GET,OPTIONS'"
}
