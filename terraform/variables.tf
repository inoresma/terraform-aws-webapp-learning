variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Region of the app in AWS"
}

variable "environment" {
  description = "Environment name for resource tagging"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}
