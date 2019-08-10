# ---------------------------------------------------------------
# AWS Certificate Manager - Web
# ---------------------------------------------------------------
resource "aws_acm_certificate" "web" {
  provider = "aws.global"

  domain_name       = "cards.${data.aws_route53_zone.this.name}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# ---------------------------------------------------------------
# AWS Route53 Record - Web Certificate
# ---------------------------------------------------------------
resource "aws_route53_record" "web_validation" {
  provider   = "aws.global"
  depends_on = ["aws_acm_certificate.web"]
  name       = "${aws_acm_certificate.web.domain_validation_options.0.resource_record_name}"
  type       = "${aws_acm_certificate.web.domain_validation_options.0.resource_record_type}"
  zone_id    = "${data.aws_route53_zone.this.zone_id}"
  records    = ["${aws_acm_certificate.web.domain_validation_options.0.resource_record_value}"]
  ttl        = 60
}

# ---------------------------------------------------------------
# AWS Certificate Manager - Web Validation
# ---------------------------------------------------------------
resource "aws_acm_certificate_validation" "web" {
  provider                = "aws.global"
  certificate_arn         = "${aws_acm_certificate.web.arn}"
  validation_record_fqdns = ["${aws_route53_record.web_validation.fqdn}"]
}
