
# # ---------------------------------------------------------------
# # AWS Cognito Role Attachment
# # ---------------------------------------------------------------
# resource "aws_cognito_identity_pool_roles_attachment" "this" {
#   identity_pool_id = "${local.cognito_identity_pool_id}"

#   # role_mapping {
#   #   identity_provider         = "graph.facebook.com"
#   #   ambiguous_role_resolution = "AuthenticatedRole"
#   #   type                      = "Rules"

#   #   mapping_rule {
#   #     claim      = "isAdmin"
#   #     match_type = "Equals"
#   #     role_arn   = "${aws_iam_role.cognito.arn}"
#   #     value      = "paid"
#   #   }
#   # }

#   roles = {
#     "authenticated"   = "${aws_iam_role.cognito_authenticated.arn}"
#     "unauthenticated" = "${aws_iam_role.cognito_unauthenticated.arn}"
#   }
# }
# # ---------------------------------------------------------------
# # AWS Cognito Authenticated Principals JSON
# # ---------------------------------------------------------------
# data "template_file" "cognito_authenticated" {
#   template = "${file("iam/cognito_principal_auth.tpl")}"
#   vars = {
#     identity_pool_id = "${local.cognito_identity_pool_id}"
#   }
# }

# # ---------------------------------------------------------------
# # AWS Cognito Authenticated Role
# # ---------------------------------------------------------------
# resource "aws_iam_role" "cognito_authenticated" {
#   name = "${local.project_name_uc}_Cognito_AuthRole"

#   assume_role_policy = "${data.template_file.cognito_authenticated.rendered}"
# }

# # ---------------------------------------------------------------
# # AWS Cognito Authenticated Policy
# # ---------------------------------------------------------------
# data "template_file" "cognito_policy_authenticated" {
#   template = "${file("iam/cognito_policy_auth.tpl")}"
#   vars = {
#     api_execution_arn = "${aws_api_gateway_stage.this.execution_arn}/*"
#   }
# }

# resource "aws_iam_role_policy" "cognito_policy_authenticated" {
#   role = "${aws_iam_role.cognito_authenticated.id}"

#   policy = "${data.template_file.cognito_policy_authenticated.rendered}"
# }

# # ---------------------------------------------------------------
# # AWS Cognito UnAuthenticated Principals JSON
# # ---------------------------------------------------------------
# data "template_file" "cognito_unauthenticated" {
#   template = "${file("iam/cognito_principal_unauth.tpl")}"
#   vars = {
#     identity_pool_id = "${local.cognito_identity_pool_id}"
#   }
# }

# # ---------------------------------------------------------------
# # AWS Cognito UnAuthenticated Role
# # ---------------------------------------------------------------
# resource "aws_iam_role" "cognito_unauthenticated" {
#   name = "${local.project_name_uc}_Cognito_UnauthRole"

#   assume_role_policy = "${data.template_file.cognito_unauthenticated.rendered}"
# }

# # ---------------------------------------------------------------
# # AWS Cognito UnAuthenticated Policy
# # ---------------------------------------------------------------
# resource "aws_iam_role_policy" "cognito_policy_unauthenticated" {
#   role = "${aws_iam_role.cognito_unauthenticated.id}"

#   policy = "${file("iam/cognito_policy_unauth.json")}"
# }
