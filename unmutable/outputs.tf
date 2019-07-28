# -----------------------------------------------
# S3 Bucket
# -----------------------------------------------
output "frontend_bucket_name" {
  value = "${aws_s3_bucket.frontend.id}"
}
output "frontend_bucket_arn" {
  value = "${aws_s3_bucket.frontend.arn}"
}
output "frontend_bucket_regional_domain_name" {
  value = "${aws_s3_bucket.frontend.bucket_regional_domain_name}"
}
output "audios_bucket_name" {
  value = "${aws_s3_bucket.audios.id}"
}
output "audios_bucket_arn" {
  value = "${aws_s3_bucket.audios.arn}"
}
output "audios_bucket_regional_domain_name" {
  value = "${aws_s3_bucket.audios.bucket_regional_domain_name}"
}
output "logging_bucket_name" {
  value = "${aws_s3_bucket.logging.id}"
}
output "logging_bucket_arn" {
  value = "${aws_s3_bucket.logging.arn}"
}
output "logging_bucket_regional_domain_name" {
  value = "${aws_s3_bucket.logging.bucket_regional_domain_name}"
}
# -----------------------------------------------
# DynamoDB
# -----------------------------------------------

output "dynamodb_users_name" {
  value = "${aws_dynamodb_table.users.name}"
}
output "dynamodb_users_arn" {
  value = "${aws_dynamodb_table.users.arn}"
}
output "dynamodb_users_stream_arn" {
  value = "${aws_dynamodb_table.users.stream_arn}"
}
output "dynamodb_user_groups_name" {
  value = "${aws_dynamodb_table.user_groups.name}"
}
output "dynamodb_user_groups_arn" {
  value = "${aws_dynamodb_table.user_groups.arn}"
}
output "dynamodb_user_groups_stream_arn" {
  value = "${aws_dynamodb_table.user_groups.stream_arn}"
}
output "dynamodb_group_words_name" {
  value = "${aws_dynamodb_table.group_words.name}"
}
output "dynamodb_group_words_arn" {
  value = "${aws_dynamodb_table.group_words.arn}"
}
output "dynamodb_group_words_stream_arn" {
  value = "${aws_dynamodb_table.group_words.stream_arn}"
}
output "dynamodb_words_name" {
  value = "${aws_dynamodb_table.words.name}"
}
output "dynamodb_words_arn" {
  value = "${aws_dynamodb_table.words.arn}"
}
output "dynamodb_words_stream_arn" {
  value = "${aws_dynamodb_table.words.stream_arn}"
}
output "dynamodb_history_name" {
  value = "${aws_dynamodb_table.history.name}"
}
output "dynamodb_history_arn" {
  value = "${aws_dynamodb_table.history.arn}"
}
output "dynamodb_history_stream_arn" {
  value = "${aws_dynamodb_table.history.stream_arn}"
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
output "devops_repo" {
  value = "${var.devops_repo}"
}
output "devops_owner" {
  value = "${var.devops_owner}"
}
output "devops_branch" {
  value = "${var.devops_branch}"
}
output "mtn_repo" {
  value = "${var.mtn_repo}"
}
output "mtn_owner" {
  value = "${var.mtn_owner}"
}
output "mtn_branch" {
  value = "${var.mtn_branch}"
}
