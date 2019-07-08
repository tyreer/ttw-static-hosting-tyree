variable region {
  default = "eu-west-2"
}

# arn:aws:acm:us-east-1:965185280735:certificate/09fabdf0-d459-441d-bfe5-772575bac103
variable "SSL_CERTIFICATE" {
  type = "map"

  default = {
    develop    = ""
    staging    = ""
    production = ""
  }
}

# develop-ttw-static-demo.stink.co
variable "FRONTEND_ALIASES" {
  type = "map"

  default = {
    develop    = [""]
    staging    = [""]
    production = [""]
  }
}
# arn:aws:acm:us-east-1:965185280735:certificate/09fabdf0-d459-441d-bfe5-772575bac103
variable "FRONTEND_LAMBDA_FUNCTION_ASSOCIATION" {
  type = "map"

  default = {
    develop    = ""
    staging    = ""
    production = ""
  }
}
