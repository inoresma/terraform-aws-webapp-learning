# DB Subnet Group
#Here we use 2 private subnets, if i activate mode multi az, rds will use one for the instance and the other one for the replica
resource "aws_db_subnet_group" "main" {
  name_prefix = "${var.environment}-db-subnet-group-"
  subnet_ids  = var.private_subnet_ids

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-db-subnet-group"
      Type = "DB Subnet Group"
    }
  )
}

# DB Parameter Group
#This parameter has been created for auditing purposes.
#Here we enable the logs of connections with the database, if an user connects or disconnect
resource "aws_db_parameter_group" "main" {
  family = "${var.db_engine}${var.db_engine_version}"
  name   = "${var.environment}-db-parameter-group"

  parameter {
    name  = "log_connections"
    value = "1"
  }

  parameter {
    name  = "log_disconnections"
    value = "1"
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-db-parameter-group"
      Type = "DB Parameter Group"
    }
  )
}

# DB Instance
resource "aws_db_instance" "main" {
  identifier = "${var.environment}-notesapp-db"

  # Engine configuration
  engine         = var.db_engine
  engine_version = var.db_engine_version
  instance_class = var.db_instance_class

  # Storage configuration
  allocated_storage     = var.allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = true
  max_allocated_storage = var.allocated_storage * 2

  # Database configuration
  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  # Network configuration
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.security_group_id]
  publicly_accessible    = false
  multi_az               = var.environment == "prod" ? true : false

  # Backup configuration
  backup_retention_period = var.backup_retention_period
  backup_window          = var.backup_window
  maintenance_window     = var.maintenance_window

  # Security configuration
  deletion_protection = var.deletion_protection
  skip_final_snapshot = var.skip_final_snapshot

  # Performance configuration
  parameter_group_name = aws_db_parameter_group.main.name

  # Monitoring
  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.rds_monitoring.arn

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-notesapp-db"
      Type = "RDS Instance"
    }
  )

  depends_on = [aws_db_subnet_group.main, aws_db_parameter_group.main]
}

# IAM Role for RDS Enhanced Monitoring
resource "aws_iam_role" "rds_monitoring" {
  name = "${var.environment}-rds-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-rds-monitoring-role"
      Type = "IAM Role"
    }
  )
}

# Attach the RDS monitoring policy to the role
resource "aws_iam_role_policy_attachment" "rds_monitoring" {
  role       = aws_iam_role.rds_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
