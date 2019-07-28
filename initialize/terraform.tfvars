# --------------------------------------------------------------------------------
# Terraform Configs
# --------------------------------------------------------------------------------
shared_credentials_file = "C:\\Users\\remoter\\.aws\\credentials"
aws_profile             = "default"

# --------------------------------------------------------------------------------
# AWS Commons
# --------------------------------------------------------------------------------
region       = "ap-northeast-1"
project_name = "pocket-cards"

translation_url = "https://translation.googleapis.com/language/translate/v2"
ipa_url         = "https://m1rb1oo72l.execute-api.ap-northeast-1.amazonaws.com/v1"

# --------------------------------------------------------------------------------
# Source Configs
# --------------------------------------------------------------------------------
backend_repo  = "pocket-cards-backend"
backend_owner = "wwalpha"

frontend_repo  = "pocket-cards-frontend"
frontend_owner = "wwalpha"

devops_repo  = "pocket-cards-devops"
devops_owner = "wwalpha"

mtn_repo  = "pocket-cards-maintenance"
mtn_owner = "wwalpha"

infra_repo  = "pocket-cards-terraform"
infra_owner = "wwalpha"
