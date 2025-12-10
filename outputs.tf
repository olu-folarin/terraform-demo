output "data_bucket_name" {
  description = "Name of the data S3 bucket"
  value       = aws_s3_bucket.data_bucket.id
}

output "data_bucket_arn" {
  description = "ARN of the data S3 bucket"
  value       = aws_s3_bucket.data_bucket.arn
}

output "logs_bucket_name" {
  description = "Name of the logs S3 bucket"
  value       = aws_s3_bucket.logs_bucket.id
}

output "logs_bucket_arn" {
  description = "ARN of the logs S3 bucket"
  value       = aws_s3_bucket.logs_bucket.arn
}
