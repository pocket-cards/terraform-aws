# -----------------------------------------------
# AWS Provider
# -----------------------------------------------
provider "aws" {
  profile = "${var.profile}"
}

# -----------------------------------------------
# Terraform Settings
# -----------------------------------------------
terraform {
  backend "s3" {
    bucket = "terraform-workspaces"
    region = "ap-northeast-1"
    key    = "pocket-cards/initialize.tfstate"
  }

  required_version = ">= 0.12"
}
