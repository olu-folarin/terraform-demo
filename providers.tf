terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Remote state backend - uncomment after creating the S3 bucket
  # backend "s3" {
  #   bucket         = "your-terraform-state-bucket"
  #   key            = "terraform-demo/terraform.tfstate"
  #   region         = "eu-west-2"
  #   encrypt        = true
  #   dynamodb_table = "terraform-state-lock"
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project    = "terraform-demo"
      ManagedBy  = "terraform"
      Repository = "terraform-demo"
    }
  }
}
