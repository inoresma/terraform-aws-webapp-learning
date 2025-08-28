output "bucket_id" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.main.id
}

output "bucket_domain_name" {
  description = "The bucket domain name"
  value       = aws_s3_bucket.main.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "The bucket region-specific domain name"
  value       = aws_s3_bucket.main.bucket_regional_domain_name
}

output "bucket_region" {
  description = "The AWS region this bucket resides in"
  value       = aws_s3_bucket.main.region
}


output "bucket_public_access_blocked" {
  description = "Whether public access is blocked for this bucket"
  value       = var.bucket_public_access_block
}


output "bucket_cors_rules" {
  description = "The CORS rules configured for the bucket"
  value       = var.bucket_cors_rules
}
