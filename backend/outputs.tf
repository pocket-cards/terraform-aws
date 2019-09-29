output "rest_api_id" {
  value = "${aws_api_gateway_rest_api.this.id}"
}
output "api_domain_name" {
  value = "${aws_acm_certificate.api.domain_name}"
}
output "api_execution_arn" {
  value = "${aws_api_gateway_stage.this.execution_arn}"
}
# output "rest_api_stage_name" {
#   value = "${aws_api_gateway_stage.this.stage_name}"
# }
# output "name" {
#   value = "${aws_route53_record.api.name}"
# }
# output "fqdn" {
#   value = "${aws_route53_record.api.fqdn}"
# }
