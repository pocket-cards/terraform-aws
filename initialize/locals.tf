locals {
  /** UpperCamel */
  project_name          = "${var.project_name}"
  project_name_uc       = "${replace(title(var.project_name), "-", "")}"
  project_name_stn      = "PKCD"
  environment           = "${terraform.workspace}"
  bucket_name_artifacts = "${local.project_name}-artifacts-${random_id.bucket.hex}"
}
