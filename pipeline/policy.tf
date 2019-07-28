
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
# DynamoDB Access Policy
# -----------------------------------------------
data "aws_iam_policy_document" "dynamodb_access_policy" {
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
# Rekognition Access Policy
# -----------------------------------------------
data "aws_iam_policy_document" "rekognition_access_policy" {
  statement {
    actions = [
      "rekognition:ListCollections",
      "rekognition:DescribeCollection",
      "rekognition:SearchFaces",
      "rekognition:ListStreamProcessors",
      "rekognition:DescribeStreamProcessor",
      "rekognition:SearchFacesByImage",
      "rekognition:ListFaces"
    ]

    effect = "Allow"

    resources = [
      "arn:aws:rekognition:${local.region}:*:streamprocessor/*",
      "arn:aws:rekognition:${local.region}:*:collection/*"
    ]
  }
}


