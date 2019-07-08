resource "aws_s3_bucket" "frontend" {
  bucket = "${terraform.workspace}-ttw-demo-frontend"
  acl    = "public-read"

  # * POLICY PERMISSIONS
  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [{
		"Sid": "PublicReadGetObject",
		"Effect": "Allow",
		"Principal": "*",
		"Action": ["s3:GetObject"],
		"Resource": ["arn:aws:s3:::${terraform.workspace}-ttw-demo-frontend/*"]
	}]
}
EOF

  # * S3 STATIC HOSTING
  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  # * CORS RULES
	cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }
}