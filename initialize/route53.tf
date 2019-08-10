# ---------------------------------------------------------------
# AWS Route53
# ---------------------------------------------------------------
resource "aws_route53_zone" "this" {
  name = "${local.domain_prefix}${var.domain_name}"
}

resource "aws_route53_record" "ns" {
  zone_id = "${aws_route53_zone.this.zone_id}"
  name    = "dev.${var.domain_name}"
  type    = "NS"
  ttl     = "30"
  records = "${var.dns_name_servers}"
  count   = "${local.is_dev ? 0 : 1}"
}
