# resource "aws_route53_record" "record_acm" {
#   zone_id = "${var.hosted_zone_id}"
#   name    = "acm.aws-handson.com."
#   type    = "${local.record_type_cname}"
#   ttl     = "${local.route53_ttl}"
#   records = ["${var.acm_value}"]
# }

# resource "aws_route53_record" "record_api" {
#   zone_id = "${var.hosted_zone_id}"
#   name    = "${var.custom_domain_api}."
#   type    = "${local.record_type_cname}"
#   ttl     = "${local.route53_ttl}"
#   records = ["${local.api_gateway_domain}"]
# }

# resource "aws_route53_record" "record_web" {
#   zone_id = "${var.hosted_zone_id}"
#   name    = "${var.custom_domain_web}."
#   type    = "${local.record_type_cname}"
#   ttl     = "${local.route53_ttl}"
#   records = ["${aws_cloudfront_distribution.this.domain_name}"]
# }
