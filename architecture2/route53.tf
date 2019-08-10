# ------------------------------------------------
# AWS Route53 Record - CloudFront Alias Record
# ------------------------------------------------
resource "aws_route53_record" "frontend" {
  name    = "cards.${data.aws_route53_zone.this.name}"
  type    = "A"
  zone_id = "${data.aws_route53_zone.this.id}"

  alias {
    evaluate_target_health = false
    name                   = "${aws_cloudfront_distribution.this.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.this.hosted_zone_id}"
  }
}
