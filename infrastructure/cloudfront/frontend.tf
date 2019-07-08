resource "aws_cloudfront_distribution" "frontend" {
  origin {
    domain_name = "${var.MEDIA_DOMAIN_NAME}"
    origin_id   = "${var.MEDIA_ORIGIN_ID}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  enabled = true
  # ! UNCOMMENT IF YOU HAVE DOMAIN AND SSL SETUP
  # aliases = "${var.FRONTEND_ALIASES[terraform.workspace]}"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.MEDIA_ORIGIN_ID}"

    # Forward all query strings, cookies and headers
    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    compress               = true

    # ! UN COMMENT OUT TO ENABLE AUTH LAMBA (ADD VARIABLE TO MAIN VARIABLES FILE)
    # lambda_function_association {
    #   event_type   = "viewer-request"
    #   lambda_arn   = "${lookup(var.FRONTEND_LAMBDA_FUNCTION_ASSOCIATION, terraform.workspace)}"
    #   include_body = false
    # }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  # Distributes content to US and Europe
  price_class = "PriceClass_100"

  # Restricts who is able to access this content
  restrictions {
    geo_restriction {
      # type of restriction, blacklist, whitelist or none
      restriction_type = "none"
    }
  }

  # ! COMMENT OUT IF YOU HAVE YOUR OWN SSL (ADD SSL ARN TO VARIABLE SSL_CERTIFICATE)
  # viewer_certificate {
  #   acm_certificate_arn      = "${lookup(var.SSL_CERTIFICATE, terraform.workspace)}"
  #   ssl_support_method       = "sni-only"
  #   minimum_protocol_version = "TLSv1"
  # }

  # ! REMOVE IF YOU HAVE YOUR OWN SSL
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
