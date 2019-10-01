# output "cloudfront_ditribution_id" {
#   value = "${aws_cloudfront_distribution.this.id}"
# }

output "web_domain_name" {
  value = "${aws_acm_certificate.web.domain_name}"
}
