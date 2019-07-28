locals {
  # -----------------------------------------------
  # Project Informations
  # -----------------------------------------------
  remote_init = "${data.terraform_remote_state.initialize.outputs}"
  remote_unmu = "${data.terraform_remote_state.unmutable.outputs}"

  account_id      = "${local.remote_init.account_id}"
  project_name    = "${local.remote_init.project_name}"
  project_name_uc = "${local.remote_init.project_name_uc}"
  region          = "${local.remote_init.region}"
  environment     = "${terraform.workspace}"
  github_token    = "${local.remote_init.ssm_param_github_token}"

  code_deploy_role = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/AWSCodeDeployLambda"

  # -----------------------------------------------
  # S3 Bucket
  # -----------------------------------------------
  frontend_bucket_id   = "${local.remote_init.frontend_bucket_name}"
  artifacts_bucket_id  = "${local.remote_init.artifacts_bucket_name}"
  artifacts_bucket_arn = "${local.remote_init.artifacts_bucket_arn}"

  # -----------------------------------------------
  # CloudFront
  # -----------------------------------------------
  # cloudfront_id = "${local.remote_main.cloudfront_ditribution_id}"

  # -----------------------------------------------
  # Source Configs
  # -----------------------------------------------
  backend_repo   = "${local.remote_init.backend_repo}"
  backend_owner  = "${local.remote_init.backend_owner}"
  backend_branch = "${local.remote_init.backend_branch}"

  frontend_repo   = "${local.remote_init.frontend_repo}"
  frontend_owner  = "${local.remote_init.frontend_owner}"
  frontend_branch = "${local.remote_init.frontend_branch}"

  devops_repo   = "${local.remote_init.devops_repo}"
  devops_owner  = "${local.remote_init.devops_owner}"
  devops_branch = "${local.remote_init.devops_branch}"
}
