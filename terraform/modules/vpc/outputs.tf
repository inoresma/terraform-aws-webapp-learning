output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = aws_vpc.main.arn
}

output "public_subnet_ids" {
  description = "Map of public subnet IDs"
  value       = { for k, v in aws_subnet.public : k => v.id }
}

output "private_subnet_ids" {
  description = "Map of private subnet IDs"
  value       = { for k, v in aws_subnet.private : k => v.id }
}

output "public_subnet_arns" {
  description = "Map of public subnet ARNs"
  value       = { for k, v in aws_subnet.public : k => v.arn }
}

output "private_subnet_arns" {
  description = "Map of private subnet ARNs"
  value       = { for k, v in aws_subnet.private : k => v.arn }
}

output "public_subnet_cidr_blocks" {
  description = "Map of public subnet CIDR blocks"
  value       = { for k, v in aws_subnet.public : k => v.cidr_block }
}

output "private_subnet_cidr_blocks" {
  description = "Map of private subnet CIDR blocks"
  value       = { for k, v in aws_subnet.private : k => v.cidr_block }
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs"
  value       = aws_nat_gateway.main[*].id
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.private.id
}

output "nat_gateway_public_ips" {
  description = "List of Elastic IPs of NAT Gateways"
  value       = aws_eip.nat[*].public_ip
}