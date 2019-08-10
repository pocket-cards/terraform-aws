# -----------------------------------------------
# AWS Provider
# -----------------------------------------------
provider "aws" {
  profile = "${var.profile}"
}

# provider "aws" {
#   assume_role {
#     role_arn = "arn:aws:iam::562849865336:role/TerraformRole"
#   }
#   alias = "prod"
# }

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
