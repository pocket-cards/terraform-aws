# -----------------------------------------------
# AWS Provider
# -----------------------------------------------
provider "aws" {
  region = "${local.region}"

  assume_role {
    role_arn    = "arn:aws:iam::${local.account_id}:role/TerraformRole"
    external_id = "pocket-cards"
  }
}

# -----------------------------------------------
# Terraform Settings
# -----------------------------------------------
terraform {
  backend "s3" {
    bucket = "terraform-workspaces"
    region = "ap-northeast-1"
    key    = "pocket-cards/pipeline.tfstate"
  }

  required_version = ">= 0.12"
}

# -----------------------------------------------
# Remote state - Initialize
# -----------------------------------------------
data "terraform_remote_state" "initialize" {
  backend   = "s3"
  workspace = "${terraform.workspace}"

  config = {
    bucket = "terraform-workspaces"
    region = "ap-northeast-1"
    key    = "pocket-cards/initialize.tfstate"
  }
}

# -----------------------------------------------
# Remote state - Unmutable
# -----------------------------------------------
data "terraform_remote_state" "unmutable" {
  backend   = "s3"
  workspace = "${terraform.workspace}"

  config = {
    bucket = "terraform-workspaces"
    region = "ap-northeast-1"
    key    = "pocket-cards/unmutable.tfstate"
  }
}
