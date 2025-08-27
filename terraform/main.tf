# VPC Module
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block = "10.0.0.0/16"
  
  public_subnets = {
    "public-1" = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a"
    }
    "public-2" = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-1b"
    }
  }
  
  private_subnets = {
    "private-1" = {
      cidr_block        = "10.0.3.0/24"
      availability_zone = "us-east-1a"
    }
    "private-2" = {
      cidr_block        = "10.0.4.0/24"
      availability_zone = "us-east-1b"
    }
  }
  
  environment        = "dev"
  enable_nat_gateway = true
  
  common_tags = {
    Project     = "NotesApp"
    ManagedBy   = "Terraform"
    Environment = "dev"
    Owner       = "DevOps Team"
  }
}

# Security Groups Module
module "security_groups" {
  source = "./modules/security-group"

  vpc_id      = module.vpc.vpc_id
  environment = "dev"
  
  common_tags = {
    Project     = "NotesApp"
    ManagedBy   = "Terraform"
    Environment = "dev"
    Owner       = "DevOps Team"
  }
}

# RDS Module
module "rds" {
  source = "./modules/rds"

  private_subnet_ids = values(module.vpc.private_subnet_ids)
  security_group_id  = module.security_groups.rds_security_group_id
  
  environment = "dev"
  db_password = "NotesApp2024!"  # this is a bad practice but in production i will apply environments variables or AWS Secrets Manager
  
  common_tags = {
    Project     = "NotesApp"
    ManagedBy   = "Terraform"
    Environment = "dev"
    Owner       = "DevOps Team"
  }
}