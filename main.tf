# Main Terraform configuration
# Demonstrates proper tagging for cost allocation and governance

locals {
  common_tags = {
    department  = var.department
    service     = var.project_name
    environment = var.environment
    production  = var.environment == "production" ? "true" : "false"
    contact     = var.contact
    domain      = "infrastructure"
  }
}

# Example S3 bucket with proper tags
resource "aws_s3_bucket" "data_bucket" {
  bucket = "${var.project_name}-data-${var.environment}-${random_id.suffix.hex}"

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-data-bucket"
  })
}

resource "aws_s3_bucket_versioning" "data_bucket" {
  bucket = aws_s3_bucket.data_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "data_bucket" {
  bucket = aws_s3_bucket.data_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "data_bucket" {
  bucket = aws_s3_bucket.data_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Example S3 bucket for logs
resource "aws_s3_bucket" "logs_bucket" {
  bucket = "${var.project_name}-logs-${var.environment}-${random_id.suffix.hex}"

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-logs-bucket"
  })
}

resource "aws_s3_bucket_versioning" "logs_bucket" {
  bucket = aws_s3_bucket.logs_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs_bucket" {
  bucket = aws_s3_bucket.logs_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "logs_bucket" {
  bucket = aws_s3_bucket.logs_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Random suffix for globally unique bucket names
resource "random_id" "suffix" {
  byte_length = 4
}

# ============================================
# TEST SCENARIOS FOR TAG VALIDATION
# ============================================

# Scenario 1: Missing tags (should FAIL validation)
resource "aws_s3_bucket" "missing_tags_bucket" {
  bucket = "${var.project_name}-missing-tags-${random_id.suffix.hex}"

  tags = {
    Name       = "bucket-with-missing-tags"
    department = "platform"
    # Missing: service, environment, production, contact, domain
  }
}

# Scenario 2: Partial tags (should FAIL validation)
resource "aws_s3_bucket" "partial_tags_bucket" {
  bucket = "${var.project_name}-partial-${random_id.suffix.hex}"

  tags = {
    Name        = "bucket-with-partial-tags"
    department  = "platform"
    service     = "test-service"
    environment = "staging"
    # Missing: production, contact, domain
  }
}
