output "rsschool_bucket_name" {
  value       = aws_s3_bucket.rsschool_bucket.bucket
  description = "Name of the rsschool S3 bucket"
}

output "rsschool_bucket_arn" {
  value       = aws_s3_bucket.rsschool_bucket.arn
  description = "ARN of the rsschool S3 bucket"
}
