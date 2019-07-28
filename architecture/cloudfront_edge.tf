# module "edge" {
#   source = "github.com/wwalpha/terraform-modules-lambda"

#   providers = {
#     aws = "aws.global"
#   }

#   function_name         = "${local.project_name_uc}-ResponseOrigin"
#   handler               = "index.handler"
#   runtime               = "nodejs8.10"
#   role_name             = "${local.project_name_uc}-ResponseOriginRole"
#   role_policy_json      = ["${data.aws_iam_policy_document.dynamodb_access_policy.json}"]
#   alias_name            = "dev"
#   publish               = true
#   edge                  = true
#   log_retention_in_days = "${var.lambda_log_retention_in_days}"
#   use_dummy_file        = true
#   timeout               = 5
# }
