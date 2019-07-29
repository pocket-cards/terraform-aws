output "rest_api_id" {
  value = "${aws_api_gateway_rest_api.this.id}"
}
output "rest_api_execution_arn" {
  value = "${aws_api_gateway_stage.this.execution_arn}"
}
output "rest_api_stage_name" {
  value = "${aws_api_gateway_stage.this.stage_name}"
}
