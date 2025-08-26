variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr_block, 0))
    error_message = "Must be a valid CIDR block."
  }
}

variable "public_subnets" {
  description = "Map of public subnets with their CIDR blocks and availability zones"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    "public-1" = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a"
    }
    "public-2" = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-1b"
    }
  }

  validation {
    # Condition that verify if all subnets are valids
    condition = alltrue([
      for subnet in var.public_subnets : can(cidrhost(subnet.cidr_block, 0))
    ])
    error_message = "All public subnet CIDR blocks must be valid."
  }
}

variable "private_subnets" {
  description = "Map of private subnets with their CIDR blocks and availability zones"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    "private-1" = {
      cidr_block        = "10.0.3.0/24"
      availability_zone = "us-east-1a"
    }
    "private-2" = {
      cidr_block        = "10.0.4.0/24"
      availability_zone = "us-east-1b"
    }
  }

  validation {
    condition = alltrue([
      for subnet in var.private_subnets : can(cidrhost(subnet.cidr_block, 0))
    ])
    error_message = "All private subnet CIDR blocks must be valid."
  }
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

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets"
  type        = bool
  default     = true
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "NotesApp"
    ManagedBy   = "Terraform"
    Environment = "dev"
  }
}