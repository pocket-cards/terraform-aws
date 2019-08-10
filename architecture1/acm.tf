# ---------------------------------------------------------------
# AWS Certificate Manager - API
# ---------------------------------------------------------------
resource "aws_acm_certificate" "api" {
  domain_name       = "api.${data.aws_route53_zone.this.name}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# ---------------------------------------------------------------
# AWS Route53 Record - Api Certificate
# ---------------------------------------------------------------
resource "aws_route53_record" "api_validation" {
  depends_on = ["aws_acm_certificate.api"]
  name       = "${aws_acm_certificate.api.domain_validation_options.0.resource_record_name}"
  type       = "${aws_acm_certificate.api.domain_validation_options.0.resource_record_type}"
  zone_id    = "${data.aws_route53_zone.this.zone_id}"
  records    = ["${aws_acm_certificate.api.domain_validation_options.0.resource_record_value}"]
  ttl        = 60
}

# ---------------------------------------------------------------
# AWS Certificate Manager - Api Validation
# ---------------------------------------------------------------
resource "aws_acm_certificate_validation" "api" {
  certificate_arn         = "${aws_acm_certificate.api.arn}"
  validation_record_fqdns = ["${aws_route53_record.api_validation.fqdn}"]
}
