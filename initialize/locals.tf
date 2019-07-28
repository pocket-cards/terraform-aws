locals {
  /** UpperCamel */
  project_name    = "${var.project_name}"
  project_name_uc = "${replace(title(var.project_name), "-", "")}"
  # prefix                = "${var.environment == "dev" ? "dev-" : ""}"
  prefix                = ""
  bucket_name_audio     = "${local.prefix}${local.project_name}-audios-${random_id.bucket.hex}"
  bucket_name_frontend  = "${local.prefix}${local.project_name}-frontend-${random_id.bucket.hex}"
  bucket_name_artifacts = "${local.prefix}${local.project_name}-artifacts-${random_id.bucket.hex}"
  bucket_name_logging   = "${local.prefix}${local.project_name}-logging-${random_id.bucket.hex}"

  dynamodb_name_users      = "${local.project_name_uc}_Users_${random_id.dynamodb.hex}"
  dynamodb_name_groupwords = "${local.project_name_uc}_GroupWords_${random_id.dynamodb.hex}"
  dynamodb_name_userGroups = "${local.project_name_uc}_UserGroups_${random_id.dynamodb.hex}"
  dynamodb_name_words      = "${local.project_name_uc}_Words_${random_id.dynamodb.hex}"
  dynamodb_name_history    = "${local.project_name_uc}_History_${random_id.dynamodb.hex}"
}
