# ---------------------------------------------------------------------------------------------
# Amazon API Resource - /history
# ---------------------------------------------------------------------------------------------
module "r001" {
  source = "github.com/wwalpha/terraform-module-apigateway/resource"

  rest_api_id  = module.api.id
  parent_id    = module.api.root_resource_id
  path_part    = "history"
  cors_enabled = true
  allow_method = "'GET,OPTIONS'"
}

# ---------------------------------------------------------------------------------------------
# Amazon API Resource - /groups
# ---------------------------------------------------------------------------------------------
module "r002" {
  source = "github.com/wwalpha/terraform-module-apigateway/resource"

  rest_api_id  = module.api.id
  parent_id    = module.api.root_resource_id
  path_part    = "groups"
  cors_enabled = true
  allow_method = "'POST,OPTIONS'"
}

# ---------------------------------------------------------------------------------------------
# Amazon API Resource - /groups/{groupId}
# ---------------------------------------------------------------------------------------------
module "r003" {
  source = "github.com/wwalpha/terraform-module-apigateway/resource"

  rest_api_id  = module.api.id
  parent_id    = module.r002.id
  path_part    = "{groupId}"
  cors_enabled = true
  allow_method = "'GET,PUT,DELETE,OPTIONS'"
}

# ---------------------------------------------------------------------------------------------
# Amazon API Resource - /groups/{groupId}/words
# ---------------------------------------------------------------------------------------------
module "r004" {
  source = "github.com/wwalpha/terraform-module-apigateway/resource"

  rest_api_id  = module.api.id
  parent_id    = module.r003.id
  path_part    = "words"
  cors_enabled = true
  allow_method = "'GET,POST,OPTIONS'"
}

# ---------------------------------------------------------------------------------------------
# Amazon API Resource - /groups/{groupId}/words/{word}
# ---------------------------------------------------------------------------------------------
module "r005" {
  source = "github.com/wwalpha/terraform-module-apigateway/resource"

  rest_api_id  = module.api.id
  parent_id    = module.r004.id
  path_part    = "{word}"
  cors_enabled = true
  allow_method = "'GET,PUT,OPTIONS'"
}

# ---------------------------------------------------------------------------------------------
# Amazon API Resource - /groups/{groupId}/new
# ---------------------------------------------------------------------------------------------
module "r006" {
  source = "github.com/wwalpha/terraform-module-apigateway/resource"

  rest_api_id  = module.api.id
  parent_id    = module.r003.id
  path_part    = "new"
  cors_enabled = true
  allow_method = "'POST,OPTIONS'"
}

# ---------------------------------------------------------------------------------------------
# Amazon API Resource - /groups/{groupId}/test
# ---------------------------------------------------------------------------------------------
module "r007" {
  source = "github.com/wwalpha/terraform-module-apigateway/resource"

  rest_api_id  = module.api.id
  parent_id    = module.r003.id
  path_part    = "test"
  cors_enabled = true
  allow_method = "'POST,OPTIONS'"
}

# ---------------------------------------------------------------------------------------------
# Amazon API Resource - /groups/{groupId}/review
# ---------------------------------------------------------------------------------------------
module "r008" {
  source = "github.com/wwalpha/terraform-module-apigateway/resource"

  rest_api_id  = module.api.id
  parent_id    = module.r003.id
  path_part    = "review"
  cors_enabled = true
  allow_method = "'POST,OPTIONS'"
}

# ---------------------------------------------------------------------------------------------
# Amazon API Resource - /image2text
# ---------------------------------------------------------------------------------------------
module "r009" {
  source = "github.com/wwalpha/terraform-module-apigateway/resource"

  rest_api_id  = module.api.id
  parent_id    = module.api.root_resource_id
  path_part    = "image2text"
  cors_enabled = true
  allow_method = "'POST,OPTIONS'"
}

# ---------------------------------------------------------------------------------------------
# Amazon API Resource - /image2line
# ---------------------------------------------------------------------------------------------
module "r010" {
  source = "github.com/wwalpha/terraform-module-apigateway/resource"

  rest_api_id  = module.api.id
  parent_id    = module.api.root_resource_id
  path_part    = "image2line"
  cors_enabled = true
  allow_method = "'POST,OPTIONS'"
}

