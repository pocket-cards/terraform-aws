
locals {
  # -----------------------------------------------
  # Project Informations
  # -----------------------------------------------
  remote_init = "${data.terraform_remote_state.initialize.outputs}"
  remote_unmu = "${data.terraform_remote_state.unmutable.outputs}"

  project_name    = "${local.remote_init.project_name}"
  project_name_uc = "${local.remote_init.project_name_uc}"
  environment     = "${terraform.workspace}"
  github_token    = "${local.remote_init.ssm_param_github_token}"
  region          = "${data.aws_region.this.name}"

  # -----------------------------------------------
  # S3 Bucket
  # -----------------------------------------------
  frontend_bucket_name  = "${local.remote_unmu.bucket_frontend_name}"
  artifacts_bucket_name = "${local.remote_init.bucket_artifacts_name}"

  # -----------------------------------------------
  # CloudFront
  # -----------------------------------------------
  # cloudfront_id = "${local.remote_main.cloudfront_ditribution_id}"

  # -----------------------------------------------
  # Source Configs
  # -----------------------------------------------
  backend_repo   = "${local.remote_unmu.backend_repo}"
  backend_owner  = "${local.remote_unmu.backend_owner}"
  backend_branch = "${local.remote_unmu.backend_branch}"

  frontend_repo   = "${local.remote_unmu.frontend_repo}"
  frontend_owner  = "${local.remote_unmu.frontend_owner}"
  frontend_branch = "${local.remote_unmu.frontend_branch}"

  # devops_repo   = "${local.remote_init.devops_repo}"
  # devops_owner  = "${local.remote_init.devops_owner}"
  # devops_branch = "${local.remote_init.devops_branch}"

  deployment_group_names = [
    "A002", "A003",
    "C001", "C002", "C003", "C004", "C005", "C006", "C007", "C008",
    "D001", "E001",
    "S001", "S002"
  ]
}

data "aws_caller_identity" "this" {}
data "aws_region" "this" {}
