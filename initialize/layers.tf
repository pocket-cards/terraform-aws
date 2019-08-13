// -----------------------------------------
// aws-xray-sdk
// -----------------------------------------
data "archive_file" "xray" {
  type = "zip"

  source_dir  = "build/aws-xray-sdk"
  output_path = "dist/aws-xray-sdk/nodejs.zip"
}

resource "aws_lambda_layer_version" "xray" {
  layer_name = "aws-xray-sdk"

  filename         = "${data.archive_file.xray.output_path}"
  source_code_hash = "${filebase64sha256("${data.archive_file.xray.output_path}")}"

  compatible_runtimes = ["nodejs8.10", "nodejs10.x"]
}

// -----------------------------------------
// moment
// -----------------------------------------
data "archive_file" "moment" {
  type = "zip"

  source_dir  = "build/moment"
  output_path = "dist/moment/nodejs.zip"
}

resource "aws_lambda_layer_version" "moment" {
  layer_name = "moment"

  filename         = "${data.archive_file.moment.output_path}"
  source_code_hash = "${filebase64sha256("${data.archive_file.moment.output_path}")}"

  compatible_runtimes = ["nodejs8.10", "nodejs10.x"]
}

// -----------------------------------------
// lodash
// -----------------------------------------
data "archive_file" "lodash" {
  type = "zip"

  source_dir  = "build/lodash"
  output_path = "dist/lodash/nodejs.zip"
}

resource "aws_lambda_layer_version" "lodash" {
  layer_name = "lodash"

  filename         = "${data.archive_file.lodash.output_path}"
  source_code_hash = "${filebase64sha256("${data.archive_file.lodash.output_path}")}"

  compatible_runtimes = ["nodejs8.10", "nodejs10.x"]
}


// -----------------------------------------
// axios
// -----------------------------------------
data "archive_file" "axios" {
  type = "zip"

  source_dir  = "build/axios"
  output_path = "dist/axios/nodejs.zip"
}

resource "aws_lambda_layer_version" "axios" {
  layer_name = "axios"

  filename         = "${data.archive_file.axios.output_path}"
  source_code_hash = "${filebase64sha256("${data.archive_file.axios.output_path}")}"

  compatible_runtimes = ["nodejs8.10", "nodejs10.x"]
}
