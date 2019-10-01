resource "aws_cognito_user_pool" "this" {
  name = "${local.project_name_uc}-UserPool"

  alias_attributes         = ["email"]
  auto_verified_attributes = ["email"]

  admin_create_user_config {
    allow_admin_create_user_only = false
    unused_account_validity_days = 7
  }

  password_policy {
    minimum_length    = 8
    require_lowercase = false
    require_numbers   = false
    require_symbols   = false
    require_uppercase = false
  }

  // TODO: terraform bug
  # lambda_config {
  #   post_authentication = "${module.S002.arn}"
  #   post_confirmation   = "${module.S002.arn}"
  # }

  # schema {
  #   name                     = "custom_attribute"
  #   attribute_data_type      = "Number"
  #   developer_only_attribute = false
  #   mutable                  = true
  #   required                 = false

  #   number_attribute_constraints {
  #     min_value = 1
  #     max_value = 50000000
  #   }
  # }

  # mfa_configuration = "OPTIONAL"
  mfa_configuration = "OFF"

  # sms_configuration {
  #   external_id    = "${var.environment}_${var.name}_sns_external_id"
  #   sns_caller_arn = "${aws_iam_role.cognito_sns_role.arn}"
  # }

  /*
  # email was a required field, but it ended up causing issues for any social
  # users whose identity is actually their mobile number. So to avoid problems
  # authenticating those users, we no longer require an email to be provided.
  schema {
    name                     = "email"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = true

    string_attribute_constraints {
      min_length = 1
      max_length = 2048
    }
  }
  */

}

resource "aws_cognito_user_pool_client" "this" {
  name = "client"

  user_pool_id = "${aws_cognito_user_pool.this.id}"

  generate_secret     = false
  explicit_auth_flows = ["ADMIN_NO_SRP_AUTH"]
}

# resource "aws_cognito_identity_provider" "google" {
#   user_pool_id  = "${aws_cognito_user_pool.this.id}"
#   provider_name = "Google"
#   provider_type = "Google"

#   provider_details {
#     authorize_scopes = "profile email openid"
#     client_id        = "${var.google_provider_client_id}"
#     client_secret    = "${var.google_provider_client_secret}"
#   }

#   attribute_mapping {
#     username = "sub"
#     email    = "email"
#   }
# }

resource "aws_cognito_identity_pool" "this" {
  identity_pool_name               = "${local.project_name_uc}_IdentityPool"
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id               = "${aws_cognito_user_pool_client.this.id}"
    provider_name           = "${aws_cognito_user_pool.this.endpoint}"
    server_side_token_check = false
  }

  # supported_login_providers {
  #   "graph.facebook.com"  = "${var.facebook_provider_client_id}"
  #   "accounts.google.com" = "${var.google_provider_client_id}"
  # }

  depends_on = [
    "aws_cognito_user_pool.this",
  ]
}

