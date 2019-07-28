# -----------------------------------------------
# Bucket Random Id
# -----------------------------------------------
resource "random_id" "bucket" {
  byte_length = 3
}
# -----------------------------------------------
# Amazon S3 (CodeBuild成果物保存用)
# -----------------------------------------------
resource "aws_s3_bucket" "artifacts" {
  bucket = "${local.bucket_name_artifacts}"
  acl    = "private"

  lifecycle_rule {
    enabled = true

    // ３０日後削除
    expiration {
      days = 30
    }
  }
}
