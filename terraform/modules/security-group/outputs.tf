output "alb_security_group_id" {
  description = "The ID of the ALB security group"
  value       = aws_security_group.alb.id
}

output "alb_security_group_arn" {
  description = "The ARN of the ALB security group"
  value       = aws_security_group.alb.arn
}

output "ec2_security_group_id" {
  description = "The ID of the EC2 security group"
  value       = aws_security_group.ec2.id
}

output "ec2_security_group_arn" {
  description = "The ARN of the EC2 security group"
  value       = aws_security_group.ec2.arn
}

output "rds_security_group_id" {
  description = "The ID of the RDS security group"
  value       = aws_security_group.rds.id
}

output "rds_security_group_arn" {
  description = "The ARN of the RDS security group"
  value       = aws_security_group.rds.arn
}

output "security_group_ids" {
  description = "Map of security group IDs"
  value = {
    alb = aws_security_group.alb.id
    ec2 = aws_security_group.ec2.id
    rds = aws_security_group.rds.id
  }
}

output "security_group_arns" {
  description = "Map of security group ARNs"
  value = {
    alb = aws_security_group.alb.arn
    ec2 = aws_security_group.ec2.arn
    rds = aws_security_group.rds.arn
  }
}
