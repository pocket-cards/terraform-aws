# output "cloudfront_ditribution_id" {
#   value = "${aws_cloudfront_distribution.this.id}"
# }
output "identity_pool_id" {
  value = "${aws_cognito_identity_pool.this.id}"
}
output "user_pool_id" {
  value = "${aws_cognito_user_pool.this.id}"
}
output "user_pool_web_client_id" {
  value = "${aws_cognito_user_pool_client.this.id}"
}
output "web_domain_name" {
  value = "${aws_acm_certificate.web.domain_name}"
}
