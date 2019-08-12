# -----------------------------------------------
# S3 Bucket
# -----------------------------------------------
output "bucket_frontend_name" {
  value = "${aws_s3_bucket.frontend.id}"
}
output "bucket_images_name" {
  value = "${aws_s3_bucket.images.id}"
}
output "bucket_audios_name" {
  value = "${aws_s3_bucket.audios.id}"
}
output "bucket_logging_name" {
  value = "${aws_s3_bucket.logging.id}"
}
# -----------------------------------------------
# DynamoDB
# -----------------------------------------------
output "dynamodb_users_name" {
  value = "${aws_dynamodb_table.users.name}"
}
output "dynamodb_user_groups_name" {
  value = "${aws_dynamodb_table.user_groups.name}"
}
output "dynamodb_group_words_name" {
  value = "${aws_dynamodb_table.group_words.name}"
}
output "dynamodb_words_name" {
  value = "${aws_dynamodb_table.words.name}"
}
output "dynamodb_history_name" {
  value = "${aws_dynamodb_table.history.name}"
}
output "dynamodb_tables" {
  value = [
    "${aws_dynamodb_table.users.name}",
    "${aws_dynamodb_table.user_groups.name}",
    "${aws_dynamodb_table.group_words.name}",
    "${aws_dynamodb_table.words.name}",
    "${aws_dynamodb_table.history.name}"
  ]
}

# -----------------------------------------------
# Source Configs
# -----------------------------------------------
output "backend_repo" {
  value = "${var.backend_repo}"
}
output "backend_owner" {
  value = "${var.backend_owner}"
}
output "backend_branch" {
  value = "${var.backend_branch}"
}
output "frontend_repo" {
  value = "${var.frontend_repo}"
}
output "frontend_owner" {
  value = "${var.frontend_owner}"
}
output "frontend_branch" {
  value = "${var.frontend_branch}"
}
output "automation_repo" {
  value = "${var.automation_repo}"
}
output "automation_owner" {
  value = "${var.automation_owner}"
}
output "automation_branch" {
  value = "${var.automation_branch}"
}
