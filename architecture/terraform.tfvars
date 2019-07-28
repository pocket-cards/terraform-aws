# --------------------------------------------------------------------------------
# Terraform Configs
# --------------------------------------------------------------------------------
shared_credentials_file = "C:\\Users\\remoter\\.aws\\credentials"
aws_profile             = "default"

# --------------------------------------------------------------------------------
# AWS Commons
# --------------------------------------------------------------------------------
lambda_log_retention_in_days = 14
cors_allow_origin            = "'*'"
timezone                     = "Asia/Tokyo"

# --------------------------------------------------------------------------------
# AWS Route53
# --------------------------------------------------------------------------------
hosted_zone_id    = "Z2D5VZR7KGVEAT"
custom_domain_web = "cards.aws-handson.com"
custom_domain_api = "api.aws-handson.com"

# --------------------------------------------------------------------------------
# Certificate Manager
# --------------------------------------------------------------------------------
certificate_arn = "arn:aws:acm:us-east-1:311178267809:certificate/c9ddab2f-2fb7-4307-98f1-da2b4d1a2fb8"
acm_value       = "_d7e9cb1c4904d1e85c2352c1c72a45b4.ltfvzjuylp.acm-validations.aws."

# --------------------------------------------------------------------------------
# Others
# --------------------------------------------------------------------------------

