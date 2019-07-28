# resource "aws_cloudtrail" "this" {
#   name                          = "${var.project}-trail"
#   s3_bucket_name                = "${aws_s3_bucket.logs.id}"
#   s3_key_prefix                 = "${local.ct_prefix}"
#   include_global_service_events = false
#   is_multi_region_trail         = false
# }
