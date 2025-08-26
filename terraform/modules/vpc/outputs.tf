output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_cidr_blocks" {
  description = "Map of public subnet CIDR blocks"
  value       = { for k, v in aws_subnet.public : k => v.cidr_block }
}

output "private_subnet_cidr_blocks" {
  description = "Map of private subnet CIDR blocks"
  value       = { for k, v in aws_subnet.private : k => v.cidr_block }
}

output "nat_gateway_public_ips" {
  description = "List of Elastic IPs of NAT Gateways"
  value       = aws_eip.nat[*].public_ip
}