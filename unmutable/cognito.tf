# -----------------------------------------------
# Amazon Cognito
# -----------------------------------------------
module "cognito" {
  source = "github.com/wwalpha/terraform-module-cognito"

  user_pool_name     = "${local.project_name_uc}-UserPool"
  identity_pool_name = "${local.project_name_uc}_IdentityPool"

  auto_verified_attributes   = ["email"]
  password_minimum_length    = 8
  password_require_lowercase = false
  password_require_numbers   = false
  password_require_symbols   = false
  password_require_uppercase = false
}
