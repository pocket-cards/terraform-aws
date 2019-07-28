provider "aws" {
  shared_credentials_file = "${var.shared_credentials_file}"
  profile                 = "${var.aws_profile}"
  region                  = "${var.region}"

  # assume_role {
  #   # role_arn     = "arn:aws:iam::311178267809:role/CodeBuildTerraformRole"
  #   role_arn     = "arn:aws:iam::311178267809:role/CodeBuildAssumeTestRole"
  #   session_name = "SESSION_NAME"
  #   external_id  = "EXTERNAL_ID"
  # }
}

terraform {
  backend "s3" {
    bucket = "terraform-workspaces"
    region = "ap-northeast-1"
    key    = "pocket-cards/initialize.tfstate"
  }

  required_version = ">= 0.12"
}

