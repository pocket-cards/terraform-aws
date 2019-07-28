resource "aws_ssm_parameter" "slack" {
  name  = "/${local.project_name}/slack_url"
  type  = "String"
  value = "${var.slack_url}"

  lifecycle {
    ignore_changes = ["overwrite"]
  }
}

resource "aws_ssm_parameter" "translation_api_key" {
  name  = "/${local.project_name}/translation_api_key"
  type  = "String"
  value = "${var.translation_api_key}"

  lifecycle {
    ignore_changes = ["overwrite"]
  }
}

resource "aws_ssm_parameter" "ipa_api_key" {
  name  = "/${local.project_name}/ipa_api_key"
  type  = "String"
  value = "${var.ipa_api_key}"

  lifecycle {
    ignore_changes = ["overwrite"]
  }
}
