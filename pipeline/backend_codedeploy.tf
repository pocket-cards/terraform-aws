# -----------------------------------------------
# AWS CodeDeploy
# -----------------------------------------------
resource "aws_codedeploy_app" "backend" {
  compute_platform = "Lambda"
  name             = "${local.project_name_uc}-Backend"
}
