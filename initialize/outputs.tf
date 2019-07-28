# --------------------------------------------------------------------------------
# Security Configs
# --------------------------------------------------------------------------------
output "ssm_param_slack_url" {
  value = "${aws_ssm_parameter.slack_url.name}"
}

output "ssm_param_translation_api_key" {
  value = "${aws_ssm_parameter.translation_api_key.name}"
}

output "ssm_param_ipa_api_key" {
  value = "${aws_ssm_parameter.ipa_api_key.name}"
}
