output "FRONTEND_BUCKET_NAME" {
  value = "${aws_s3_bucket.frontend.bucket}"
} 

output "FRONTEND_BUCKET_ARN" {
  value = "${aws_s3_bucket.frontend.arn}"
} 

output "FRONTEND_BUCKET_REGION" {
  value = "${aws_s3_bucket.frontend.region}"
} 

output "FRONTEND_WEBSITE_ENDPOINT" {
  value = "${aws_s3_bucket.frontend.website_endpoint}"
} 

output "FRONTEND_DOMAIN_NAME" {
  value = "${aws_s3_bucket.frontend.bucket_domain_name}"
} 