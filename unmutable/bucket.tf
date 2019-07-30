# -----------------------------------------------
# Bucket Random Id
# -----------------------------------------------
resource "random_id" "bucket" {
  byte_length = 2
}
# -----------------------------------------------
# Amazon S3 (画像保存用)
# -----------------------------------------------
resource "aws_s3_bucket" "images" {
  bucket = "${local.bucket_name_images}"
  acl    = "private"

  lifecycle_rule {
    enabled = true

    // 7日後削除
    expiration {
      days = 7
    }
  }
}
# -----------------------------------------------
# Amazon S3 (MP3保存用)
# -----------------------------------------------
resource "aws_s3_bucket" "audios" {
  bucket = "${local.bucket_name_audio}"
  acl    = "private"
}

# -----------------------------------------------
# Amazon S3 (WEBサイト)
# -----------------------------------------------
resource "aws_s3_bucket" "frontend" {
  bucket = "${local.bucket_name_frontend}"
  acl    = "private"
}

# -----------------------------------------------
# Amazon S3 (ログ保存用)
# -----------------------------------------------
resource "aws_s3_bucket" "logging" {
  bucket = "${local.bucket_name_logging}"
  acl    = "private"
}
