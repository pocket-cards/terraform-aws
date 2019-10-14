# -----------------------------------------------
# 画像から単語に変換する: /image2text
# -----------------------------------------------
module "d001" {
  source                = "github.com/wwalpha/terraform-module-registry/aws/lambda"
  dummy_enabled         = true
  function_name         = "${local.lambda.d001.function_name}"
  alias_name            = "${local.lambda_alias_name}"
  handler               = "${local.lambda_handler}"
  runtime               = "${local.lambda_runtime}"
  role_name             = "${local.lambda.d001.role_name}"
  memory_size           = 1024
  log_retention_in_days = "${var.lambda_log_retention_in_days}"
  layers                = ["${local.xray}", "${local.moment}"]

  role_policy_json = [
    "${data.aws_iam_policy_document.s3_access_policy.json}",
    "${data.aws_iam_policy_document.rekognition.json}"
  ]
  variables = {
    EXCLUDE_WORD = "",
    IMAGE_BUCKET = "${local.bucket_name_images}"
    TZ           = "${local.timezone}"
  }
}
