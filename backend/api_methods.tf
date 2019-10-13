# -------------------------------------------------------
# Amazon API Method - GET /history
# -------------------------------------------------------
module "m001" {
  source = "github.com/wwalpha/terraform-module-apigateway/method"

  rest_api_id         = "${module.api.id}"
  resource_id         = "${module.r001.id}"
  http_method         = "${local.http_method.get}"
  authorization       = "${local.authorization_type_cognito}"
  authorizer_id       = "${module.api.authorizer_id}"
  lambda_function_uri = "${module.a002.invoke_arn}"
}

# -------------------------------------------------------
# Amazon API Method - POST /groups
# -------------------------------------------------------
module "m002" {
  source = "github.com/wwalpha/terraform-module-apigateway/method"

  rest_api_id         = "${module.api.id}"
  resource_id         = "${module.r002.id}"
  http_method         = "${local.http_method.post}"
  authorization       = "${local.authorization_type_cognito}"
  authorizer_id       = "${module.api.authorizer_id}"
  lambda_function_uri = "${module.b001.invoke_arn}"
}

# -------------------------------------------------------
# Amazon API Method - GET /groups/{groupId}
# -------------------------------------------------------
module "m003" {
  source = "github.com/wwalpha/terraform-module-apigateway/method"

  rest_api_id         = "${module.api.id}"
  resource_id         = "${module.r003.id}"
  http_method         = "${local.http_method.get}"
  authorization       = "${local.authorization_type_cognito}"
  authorizer_id       = "${module.api.authorizer_id}"
  lambda_function_uri = "${module.b002.invoke_arn}"
}

# -------------------------------------------------------
# Amazon API Method - PUT /groups/{groupId}
# -------------------------------------------------------
module "m004" {
  source = "github.com/wwalpha/terraform-module-apigateway/method"

  rest_api_id         = "${module.api.id}"
  resource_id         = "${module.r003.id}"
  http_method         = "${local.http_method.put}"
  authorization       = "${local.authorization_type_cognito}"
  authorizer_id       = "${module.api.authorizer_id}"
  lambda_function_uri = "${module.b003.invoke_arn}"
}

# -------------------------------------------------------
# Amazon API Method - DELETE /groups/{groupId}
# -------------------------------------------------------
module "m005" {
  source = "github.com/wwalpha/terraform-module-apigateway/method"

  rest_api_id         = "${module.api.id}"
  resource_id         = "${module.r003.id}"
  http_method         = "${local.http_method.delete}"
  authorization       = "${local.authorization_type_cognito}"
  authorizer_id       = "${module.api.authorizer_id}"
  lambda_function_uri = "${module.b004.invoke_arn}"
}

# -------------------------------------------------------
# Amazon API Method - POST /groups/{groupId}/words
# -------------------------------------------------------
module "m006" {
  source = "github.com/wwalpha/terraform-module-apigateway/method"

  rest_api_id         = "${module.api.id}"
  resource_id         = "${module.r004.id}"
  http_method         = "${local.http_method.post}"
  authorization       = "${local.authorization_type_cognito}"
  authorizer_id       = "${module.api.authorizer_id}"
  lambda_function_uri = "${module.c001.invoke_arn}"
}

# -------------------------------------------------------
# Amazon API Method - GET /groups/{groupId}/words
# -------------------------------------------------------
module "m007" {
  source = "github.com/wwalpha/terraform-module-apigateway/method"

  rest_api_id         = "${module.api.id}"
  resource_id         = "${module.r004.id}"
  http_method         = "${local.http_method.get}"
  authorization       = "${local.authorization_type_cognito}"
  authorizer_id       = "${module.api.authorizer_id}"
  lambda_function_uri = "${module.c002.invoke_arn}"
}

# -------------------------------------------------------
# Amazon API Method - GET /groups/{groupId}/words/{word}
# -------------------------------------------------------
module "m008" {
  source = "github.com/wwalpha/terraform-module-apigateway/method"

  rest_api_id         = "${module.api.id}"
  resource_id         = "${module.r005.id}"
  http_method         = "${local.http_method.get}"
  authorization       = "${local.authorization_type_cognito}"
  authorizer_id       = "${module.api.authorizer_id}"
  lambda_function_uri = "${module.c003.invoke_arn}"
}

# -------------------------------------------------------
# Amazon API Method - PUT /groups/{groupId}/words/{word}
# -------------------------------------------------------
module "m009" {
  source = "github.com/wwalpha/terraform-module-apigateway/method"

  rest_api_id         = "${module.api.id}"
  resource_id         = "${module.r005.id}"
  http_method         = "${local.http_method.put}"
  authorization       = "${local.authorization_type_cognito}"
  authorizer_id       = "${module.api.authorizer_id}"
  lambda_function_uri = "${module.c004.invoke_arn}"
}

# -------------------------------------------------------
# Amazon API Method - GET /groups/{groupId}/new
# -------------------------------------------------------
module "m010" {
  source = "github.com/wwalpha/terraform-module-apigateway/method"

  rest_api_id         = "${module.api.id}"
  resource_id         = "${module.r006.id}"
  http_method         = "${local.http_method.get}"
  authorization       = "${local.authorization_type_cognito}"
  authorizer_id       = "${module.api.authorizer_id}"
  lambda_function_uri = "${module.c006.invoke_arn}"
}

# -------------------------------------------------------
# Amazon API Method - GET /groups/{groupId}/test
# -------------------------------------------------------
module "m011" {
  source = "github.com/wwalpha/terraform-module-apigateway/method"

  rest_api_id         = "${module.api.id}"
  resource_id         = "${module.r007.id}"
  http_method         = "${local.http_method.get}"
  authorization       = "${local.authorization_type_cognito}"
  authorizer_id       = "${module.api.authorizer_id}"
  lambda_function_uri = "${module.c007.invoke_arn}"
}


# -------------------------------------------------------
# Amazon API Method - GET /groups/{groupId}/review
# -------------------------------------------------------
module "m012" {
  source = "github.com/wwalpha/terraform-module-apigateway/method"

  rest_api_id         = "${module.api.id}"
  resource_id         = "${module.r008.id}"
  http_method         = "${local.http_method.get}"
  authorization       = "${local.authorization_type_cognito}"
  authorizer_id       = "${module.api.authorizer_id}"
  lambda_function_uri = "${module.c008.invoke_arn}"
}

# -------------------------------------------------------
# Amazon API Method - POST /image2text
# -------------------------------------------------------
module "m013" {
  source = "github.com/wwalpha/terraform-module-apigateway/method"

  rest_api_id         = "${module.api.id}"
  resource_id         = "${module.r009.id}"
  http_method         = "${local.http_method.post}"
  authorization       = "${local.authorization_type_cognito}"
  authorizer_id       = "${module.api.authorizer_id}"
  lambda_function_uri = "${module.d001.invoke_arn}"
}
