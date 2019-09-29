
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
# Lambda Access Policy
# -----------------------------------------------
data "aws_iam_policy_document" "lambda_access_policy" {
  statement {
    actions = [
      "lambda:InvokeFunction",
      "lambda:ListFunctions",
    ]

    effect = "Allow"

    resources = [
      "*"
    ]
  }
}
