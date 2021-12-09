
resource "aws_cloudfront_distribution" "root_distribution" {
  origin {
    domain_name = "${var.s3_bucket_name}.s3.us-west-2.amazonaws.com"
    origin_id   = join(".", [var.hostname, var.root_domain_name])

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods = [
      "GET",
      "HEAD",
    ]
    cached_methods = [
      "GET",
      "HEAD",
    ]
    #    target_origin_id = var.root_domain_name
    target_origin_id = join(".", [var.hostname, var.root_domain_name])
    min_ttl          = 0
    default_ttl      = 86400
    max_ttl          = 31536000

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  aliases = [
    join(".", [var.hostname, var.root_domain_name])
  ]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate_validation.default.certificate_arn
    ssl_support_method  = "sni-only"
  }
}
