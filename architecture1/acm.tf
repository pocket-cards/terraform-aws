# ---------------------------------------------------------------
# AWS Certificate Manager
# ---------------------------------------------------------------
resource "aws_acm_certificate" "domain" {
  providers = {
    aws = "aws.global"
  }

  domain_name       = "*.aws-handson.com"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
