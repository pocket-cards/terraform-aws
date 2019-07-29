provider "aws" {
  region = "${var.region}"

  assume_role {
    role_arn    = "arn:aws:iam::${var.account_id}:role/TerraformRole"
    external_id = "pocket-cards"
  }
}

terraform {
  backend "s3" {
    bucket = "terraform-workspaces"
    region = "ap-northeast-1"
    key    = "pocket-cards/initialize.tfstate"
  }

  required_version = ">= 0.12"
}
