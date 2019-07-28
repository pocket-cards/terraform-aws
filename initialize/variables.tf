# --------------------------------------------------------------------------------
# Terraform Configs
# --------------------------------------------------------------------------------
variable "shared_credentials_file" {}
variable "aws_profile" {}

# --------------------------------------------------------------------------------
# AWS Commons
# --------------------------------------------------------------------------------
variable "region" {}
variable "project_name" {}
variable "translation_url" {}
variable "ipa_url" {}

# ----------------------------------------
# Source Configs
# ----------------------------------------
variable "backend_repo" {}
variable "backend_owner" {}
variable "backend_branch" {
  default = "master"
}

variable "frontend_repo" {}
variable "frontend_owner" {}
variable "frontend_branch" {
  default = "master"
}

variable "devops_repo" {}
variable "devops_owner" {}
variable "devops_branch" {
  default = "master"
}

variable "mtn_repo" {}
variable "mtn_owner" {}
variable "mtn_branch" {
  default = "master"
}

variable "infra_repo" {}
variable "infra_owner" {}
variable "infra_branch" {
  default = "master"
}

# --------------------------------------------------------------------------------
# Security Configs
# --------------------------------------------------------------------------------
variable "translation_api_key" {}
variable "ipa_api_key" {}
variable "slack_url" {}
