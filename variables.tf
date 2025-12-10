variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "eu-west-2"
}

variable "environment" {
  description = "Environment name (staging, production)"
  type        = string
  default     = "staging"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "terraform-demo"
}

variable "department" {
  description = "Department owning the resources"
  type        = string
  default     = "platform"
}

variable "contact" {
  description = "Contact email for the resources"
  type        = string
  default     = "Platform Team: platform@example.com"
}
