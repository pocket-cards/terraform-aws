# -------------------------------------------------------
# AWS Route53 - API Gateway Record
# # -----------------------------------------------------
resource "aws_route53_record" "apigateway" {
  name    = aws_acm_certificate.api.domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.this.id

  alias {
    evaluate_target_health = true
    name                   = module.deployment.regional_domain_name
    zone_id                = module.deployment.regional_zone_id
  }
}

