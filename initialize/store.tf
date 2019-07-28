resource "aws_ssm_parameter" "slack_url" {
  name      = "/${local.project_name}/slack_url"
  type      = "SecureString"
  value     = "${var.slack_url}"
  overwrite = true
}

resource "aws_ssm_parameter" "translation_api_key" {
  name      = "/${local.project_name}/translation_api_key"
  type      = "SecureString"
  value     = "${var.translation_api_key}"
  overwrite = true
}

resource "aws_ssm_parameter" "ipa_api_key" {
  name      = "/${local.project_name}/ipa_api_key"
  type      = "SecureString"
  value     = "${var.ipa_api_key}"
  overwrite = true
}
