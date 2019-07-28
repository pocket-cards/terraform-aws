# ---------------------------------------------------------------
# AWS Cognito Role Attachment
# ---------------------------------------------------------------
resource "aws_cognito_identity_pool_roles_attachment" "this" {
  identity_pool_id = "${aws_cognito_identity_pool.this.id}"

  # role_mapping {
  #   identity_provider         = "graph.facebook.com"
  #   ambiguous_role_resolution = "AuthenticatedRole"
  #   type                      = "Rules"

  #   mapping_rule {
  #     claim      = "isAdmin"
  #     match_type = "Equals"
  #     role_arn   = "${aws_iam_role.cognito.arn}"
  #     value      = "paid"
  #   }
  # }

  roles = {
    "authenticated"   = "${aws_iam_role.cognito_authenticated.arn}"
    "unauthenticated" = "${aws_iam_role.cognito_unauthenticated.arn}"
  }
}

# ---------------------------------------------------------------
# AWS Cognito Authenticated Role
# ---------------------------------------------------------------
resource "aws_iam_role" "cognito_authenticated" {
  name = "${local.project_name_uc}-CognitoAuthRole"

  assume_role_policy = "${data.aws_iam_policy_document.cognito_authenticated_principals.json}"
}

# ---------------------------------------------------------------
# AWS Cognito Authenticated Principals JSON
# ---------------------------------------------------------------
data "aws_iam_policy_document" "cognito_authenticated_principals" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type        = "Federated"
      identifiers = ["cognito-identity.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "cognito-identity.amazonaws.com:aud"

      values = [
        "${aws_cognito_identity_pool.this.id}",
      ]
    }

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "cognito-identity.amazonaws.com:amr"

      values = [
        "authenticated",
      ]
    }
  }
}

# ---------------------------------------------------------------
# AWS Cognito Authenticated Policy
# ---------------------------------------------------------------
resource "aws_iam_role_policy" "cognito_authenticated_policy" {
  role = "${aws_iam_role.cognito_authenticated.id}"

  policy = "${data.aws_iam_policy_document.cognito_authenticated_policy_json.json}"
}

# ---------------------------------------------------------------
# AWS Cognito Authenticated Policy JSON
# ---------------------------------------------------------------
data "aws_iam_policy_document" "cognito_authenticated_policy_json" {
  statement {
    effect = "Allow"

    actions = [
      "mobileanalytics:PutEvents",
      "cognito-sync:*",
      "cognito-identity:*",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "execute-api:Invoke"
    ]

    resources = ["${local.rest_api_execution_arn}/*"]
  }
}

# ---------------------------------------------------------------
# AWS Cognito UnAuthenticated Role
# ---------------------------------------------------------------
resource "aws_iam_role" "cognito_unauthenticated" {
  name = "${local.project_name_uc}-CognitoUnauthRole"

  assume_role_policy = "${data.aws_iam_policy_document.cognito_unauthenticated_principals.json}"
}

# ---------------------------------------------------------------
# AWS Cognito UnAuthenticated Principals JSON
# ---------------------------------------------------------------
data "aws_iam_policy_document" "cognito_unauthenticated_principals" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type        = "Federated"
      identifiers = ["cognito-identity.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "cognito-identity.amazonaws.com:aud"

      values = [
        "${aws_cognito_identity_pool.this.id}",
      ]
    }

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "cognito-identity.amazonaws.com:amr"

      values = [
        "unauthenticated",
      ]
    }
  }
}

# ---------------------------------------------------------------
# AWS Cognito UnAuthenticated Policy
# ---------------------------------------------------------------
resource "aws_iam_role_policy" "cognito_unauthenticated_policy" {
  role = "${aws_iam_role.cognito_unauthenticated.id}"

  policy = "${data.aws_iam_policy_document.cognito_unauthenticated_policy_json.json}"
}

# ---------------------------------------------------------------
# AWS Cognito UnAuthenticated Policy JSON
# ---------------------------------------------------------------
data "aws_iam_policy_document" "cognito_unauthenticated_policy_json" {
  statement {
    effect = "Allow"

    actions = [
      "mobileanalytics:PutEvents",
      "cognito-sync:*",
    ]

    resources = ["*"]
  }
}
