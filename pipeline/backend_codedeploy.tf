# -----------------------------------------------
# AWS CodeDeploy
# -----------------------------------------------
resource "aws_codedeploy_app" "backend_codedeploy" {
  compute_platform = "Lambda"
  name             = "${local.project_name}-codedeploy-backend"
}

# -----------------------------------------------
# AWS CodeDeploy IAM Role
# -----------------------------------------------
# resource "aws_iam_role" "codedeploy_backend_role" {
#   name               = "${local.project_name}-CodeDeployBackendRole"
#   assume_role_policy = "${data.aws_iam_policy_document.codedeploy_backend_role.json}"
#   lifecycle {
#     create_before_destroy = false
#   }
# }

# resource "aws_iam_role_policy" "codedeploy_backend_policy" {
#   name   = "${local.project_name}-CodeDeployBackendPolicy"
#   role   = "${aws_iam_role.codedeploy_backend_role.id}"
#   policy = "${data.aws_iam_policy_document.codedeploy_backend_policy.json}"
# }
