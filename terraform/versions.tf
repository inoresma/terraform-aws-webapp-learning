terraform {
  ## the version required for this project ##
  required_version = ">= 1.0"
  
  required_providers {
    ## the version of the aws provider to work ##
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    #### provider who generates random values like a password or a name ####
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}

## this code explain how terraform conects to aws##
provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Project     = "Notes App"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}