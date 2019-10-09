
# -----------------------------------------------
# S3 Access Policy
# -----------------------------------------------
data "aws_iam_policy_document" "s3_access_policy" {
  statement {
    actions = [
      "s3:*",
    ]

    effect = "Allow"

    resources = [
      "*",
    ]
  }
}


# -----------------------------------------------
# DynamoDB Stream Policy
# -----------------------------------------------
data "aws_iam_policy_document" "dynamodb_stream" {
  statement {
    actions = [
      "dynamodb:GetRecords",
      "dynamodb:GetShardIterator",
      "dynamodb:DescribeStream",
      "dynamodb:ListStreams",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:dynamodb:${local.region}:*:table/*/stream/*"
    ]
  }
}

# -----------------------------------------------
# DynamoDB Stream Policy
# -----------------------------------------------
data "aws_iam_policy_document" "dynamodb_update" {
  statement {
    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:UpdateTable",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:dynamodb:${local.region}:*:table/*"
    ]
  }
}

# -----------------------------------------------
# Rekognition Access Policy
# -----------------------------------------------
data "aws_iam_policy_document" "rekognition" {
  statement {
    actions = [
      "rekognition:ListCollections",
      "rekognition:DescribeCollection",
      "rekognition:SearchFaces",
      "rekognition:ListStreamProcessors",
      "rekognition:DescribeStreamProcessor",
      "rekognition:SearchFacesByImage",
      "rekognition:ListFaces",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:rekognition:${local.region}:*:streamprocessor/*",
      "arn:aws:rekognition:${local.region}:*:collection/*"
    ]
  }

  statement {
    actions = [
      "rekognition:DetectText",
    ]

    effect = "Allow"

    resources = [
      "*"
    ]
  }
}

# -----------------------------------------------
# Polly Access Policy
# -----------------------------------------------
data "aws_iam_policy_document" "polly" {
  statement {
    actions = [
      "polly:*",
    ]

    effect = "Allow"

    resources = ["*"]
  }
}

# -----------------------------------------------
# Translate Access Policy
# -----------------------------------------------
data "aws_iam_policy_document" "translate" {
  statement {
    actions = [
      "translate:TranslateText"
    ]

    effect = "Allow"

    resources = ["*"]
  }
}

# -----------------------------------------------
# CloudFront Edge Policy
# -----------------------------------------------
data "aws_iam_policy_document" "cloudfront_edge_policy" {
  statement {
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:UpdateItem",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:dynamodb:${local.region}:*:table/*/index/*",
      "arn:aws:dynamodb:${local.region}:*:table/*",
    ]
  }
}

# -----------------------------------------------
# SSM Policy
# -----------------------------------------------
data "aws_iam_policy_document" "ssm_policy" {
  statement {
    actions = [
      "ssm:GetParameter",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:ssm:*:*:parameter/*",
    ]
  }
}
