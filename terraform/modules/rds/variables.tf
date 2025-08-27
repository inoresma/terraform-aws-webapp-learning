variable "private_subnet_ids" {
  description = "List of private subnet IDs for the DB subnet group"
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_ids) >= 2
    error_message = "At least 2 private subnets are required for RDS."
  }
}

variable "security_group_id" {
  description = "The ID of the security group for the RDS instance"
  type        = string

  validation {
    condition     = can(regex("^sg-", var.security_group_id))
    error_message = "Security Group ID must be a valid SG ID starting with 'sg-'."
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

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "NotesApp"
    ManagedBy   = "Terraform"
    Environment = "dev"
  }
}


### DB variables line 43 to 167
variable "db_name" {
  description = "Name of the database to create"
  type        = string
  default     = "db_notes"

  validation {
    condition     = length(var.db_name) >= 1 && length(var.db_name) <= 63
    error_message = "Database name must be between 1 and 63 characters."
  }
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
  default     = "db_admin"

  validation {
    condition     = length(var.db_username) >= 1 && length(var.db_username) <= 16
    error_message = "Database username must be between 1 and 16 characters."
  }
}

variable "db_password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.db_password) >= 8
    error_message = "Database password must be at least 8 characters long."
  }
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t3.micro"

  validation {
    condition     = can(regex("^db\\..*", var.db_instance_class))
    error_message = "DB instance class must start with 'db.'."
  }
}

variable "db_engine" {
  description = "The database engine to use"
  type        = string
  default     = "postgres"

  validation {
    condition     = contains(["postgres"], var.db_engine)
    error_message = "DB engine must be: postgres."
  }
}

variable "db_engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "15"

  validation {
    condition     = length(var.db_engine_version) >= 1
    error_message = "DB engine version cannot be empty."
  }
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 20

  validation {
    condition     = var.allocated_storage >= 20 && var.allocated_storage <= 65536
    error_message = "Allocated storage must be between 20 and 65536 GB."
  }
}

variable "storage_type" {
  description = "'gp2' (general purpose SSD)"
  type        = string
  default     = "gp2"

  validation {
    condition     = contains(["gp2"], var.storage_type)
    error_message = "Storage type must be: gp2"
  }
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 7

  validation {
    condition     = var.backup_retention_period >= 0 && var.backup_retention_period <= 35
    error_message = "Backup retention period must be between 0 and 35 days."
  }
}

variable "backup_window" {
  description = "The daily time range during which automated backups are created"
  type        = string
  default     = "03:00-04:00"
}

#Here we say to AWS when they can update the database without interfering us.
variable "maintenance_window" {
  description = "The window to perform maintenance in"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = true #change to "false" if you want an snapshot. In this case i havent
}

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled"
  type        = bool
  default     = false #its a good practice have this in "true" but im learning and i have to destroy it a lot of times, so "false"
}
