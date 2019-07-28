resource "aws_cloudfront_distribution" "this" {
  enabled             = true
  default_root_object = "${local.default_root_object}"
  aliases             = ["${var.custom_domain_web}"]

  # logging_config {
  #   bucket          = "${aws_s3_bucket.logs.bucket_domain_name}"
  #   prefix          = "${local.logging_prefix}"
  #   include_cookies = false
  # }

  origin {
    domain_name = "${local.web_bucket_regional_domain_name}"
    origin_id   = "${local.origin_id_web}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path}"
    }
  }

  origin {
    domain_name = "${local.audios_bucket_regional_domain_name}"
    origin_id   = "${local.origin_id_audio}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path}"
    }
  }

  origin {
    domain_name = "${var.custom_domain_api}"
    origin_id   = "${local.origin_id_api}"
    origin_path = "${local.origin_id_path}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_ssl_protocols   = ["TLSv1"]
      origin_protocol_policy = "https-only"
    }
  }

  custom_error_response {
    error_caching_min_ttl = 3000
    error_code            = 403
    response_code         = 200
    response_page_path    = "/${local.default_root_object}"
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${local.origin_id_web}"

    viewer_protocol_policy = "${local.viewer_protocol_policy}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  ordered_cache_behavior {
    path_pattern     = "/${local.audio_path_pattern}/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${local.origin_id_audio}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "${local.viewer_protocol_policy}"

    # lambda_function_association {
    #   event_type   = "viewer-response"
    #   lambda_arn   = "${module.edge.qualified_arn}"
    #   include_body = false
    # }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = "${var.certificate_arn}"
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.1_2016"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "${local.project_name}"
}

# ------------------------------------------------
# CloudFront Origin Access Identity Policy(WEB)
# ------------------------------------------------
resource "aws_s3_bucket_policy" "web" {
  depends_on = ["aws_cloudfront_origin_access_identity.this"]

  bucket = "${local.web_bucket_id}"
  policy = "${data.aws_iam_policy_document.web_acl.json}"
}

data "aws_iam_policy_document" "web_acl" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.this.id}"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${local.web_bucket_arn}/*"
    ]
  }
}

# ------------------------------------------------
# CloudFront Origin Access Identity Policy(audios)
# ------------------------------------------------
resource "aws_s3_bucket_policy" "audios" {
  depends_on = ["aws_cloudfront_origin_access_identity.this"]

  bucket = "${local.audios_bucket_id}"
  policy = "${data.aws_iam_policy_document.audio_acl.json}"
}

data "aws_iam_policy_document" "audio_acl" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.this.id}"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${local.audios_bucket_arn}/*"
    ]
  }
}
