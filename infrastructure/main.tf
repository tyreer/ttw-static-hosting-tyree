module "s3" {
  source = "./s3"
}

module "cloudfront" {
  source = "./cloudfront"

  MEDIA_DOMAIN_NAME                    = "${module.s3.FRONTEND_WEBSITE_ENDPOINT}"
  MEDIA_ORIGIN_ID                      = "${module.s3.FRONTEND_WEBSITE_ENDPOINT}"
  SSL_CERTIFICATE                      = "${var.SSL_CERTIFICATE}"
  FRONTEND_ALIASES                     = "${var.FRONTEND_ALIASES}"
  FRONTEND_LAMBDA_FUNCTION_ASSOCIATION = "${var.FRONTEND_LAMBDA_FUNCTION_ASSOCIATION}"
}
