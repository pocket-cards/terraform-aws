# -----------------------------------------------
# S3 Bucket
# -----------------------------------------------
output "bucket_name_frontend" {
  value = "${aws_s3_bucket.frontend.id}"
}
output "bucket_name_images" {
  value = "${aws_s3_bucket.images.id}"
}
output "bucket_name_audios" {
  value = "${aws_s3_bucket.audios.id}"
}
output "bucket_name_logging" {
  value = "${aws_s3_bucket.logging.id}"
}
# -----------------------------------------------
# DynamoDB
# -----------------------------------------------
output "dynamodb_name_users" {
  value = "${aws_dynamodb_table.users.name}"
}
output "dynamodb_name_user_groups" {
  value = "${aws_dynamodb_table.user_groups.name}"
}
output "dynamodb_name_group_words" {
  value = "${aws_dynamodb_table.group_words.name}"
}
output "dynamodb_name_words" {
  value = "${aws_dynamodb_table.words.name}"
}
output "dynamodb_name_history" {
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
output "github_organization" {
  value = "${var.github_organization}"
}
output "github_repo_frontend" {
  value = "${var.github_repo_frontend}"
}
output "github_repo_backend" {
  value = "${var.github_repo_backend}"
}
output "github_repo_automation" {
  value = "${var.github_repo_automation}"
}
