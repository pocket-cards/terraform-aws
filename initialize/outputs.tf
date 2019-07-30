# --------------------------------------------------------------------------------
# Project
# --------------------------------------------------------------------------------
output "project_name" {
  value = "${local.project_name}"
}
output "project_name_uc" {
  value = "${local.project_name_uc}"
}
output "project_name_stn" {
  value = "${local.project_name_stn}"
}
output "region" {
  value = "${var.region}"
}
output "ipa_url" {
  value = "${var.ipa_url}"
}
output "translation_url" {
  value = "${var.translation_url}"
}

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
output "ssm_param_github_token" {
  value = "${aws_ssm_parameter.github_token.name}"
}
# --------------------------------------------------------------------------------
# Bucket
# --------------------------------------------------------------------------------

output "artifacts_bucket_name" {
  value = "${aws_s3_bucket.artifacts.id}"
}
output "artifacts_bucket_arn" {
  value = "${aws_s3_bucket.artifacts.arn}"
}
output "artifacts_bucket_regional_domain_name" {
  value = "${aws_s3_bucket.artifacts.bucket_regional_domain_name}"
}

# --------------------------------------------------------------------------------
# Lambda Layer
# --------------------------------------------------------------------------------
output "layers" {
  value = {
    xray   = "${aws_lambda_layer_version.xray.arn}"
    moment = "${aws_lambda_layer_version.moment.arn}"
    lodash = "${aws_lambda_layer_version.lodash.arn}"
    axios  = "${aws_lambda_layer_version.axios.arn}"
  }
}
