locals {
  /** UpperCamel */
  project_name    = "${var.project_name}"
  project_name_uc = "${replace(title(var.project_name), "-", "")}"
  environment     = "${terraform.workspace}"
}
