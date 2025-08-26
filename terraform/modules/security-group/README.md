<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_security_group_rules"></a> [alb\_security\_group\_rules](#input\_alb\_security\_group\_rules) | Security group rules for Application Load Balancer | <pre>list(object({<br/>    type        = string<br/>    from_port   = number<br/>    to_port     = number<br/>    protocol    = string<br/>    cidr_blocks = list(string)<br/>    description = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "cidr_blocks": [<br/>      "0.0.0.0/0"<br/>    ],<br/>    "description": "HTTP from anywhere",<br/>    "from_port": 80,<br/>    "protocol": "tcp",<br/>    "to_port": 80,<br/>    "type": "ingress"<br/>  },<br/>  {<br/>    "cidr_blocks": [<br/>      "0.0.0.0/0"<br/>    ],<br/>    "description": "HTTPS from anywhere",<br/>    "from_port": 443,<br/>    "protocol": "tcp",<br/>    "to_port": 443,<br/>    "type": "ingress"<br/>  },<br/>  {<br/>    "cidr_blocks": [<br/>      "0.0.0.0/0"<br/>    ],<br/>    "description": "All outbound traffic",<br/>    "from_port": 0,<br/>    "protocol": "-1",<br/>    "to_port": 0,<br/>    "type": "egress"<br/>  }<br/>]</pre> | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common tags to apply to all resources | `map(string)` | <pre>{<br/>  "Environment": "dev",<br/>  "ManagedBy": "Terraform",<br/>  "Project": "NotesApp"<br/>}</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name for resource tagging | `string` | `"dev"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where the security groups will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_security_group_arn"></a> [alb\_security\_group\_arn](#output\_alb\_security\_group\_arn) | The ARN of the ALB security group |
| <a name="output_alb_security_group_id"></a> [alb\_security\_group\_id](#output\_alb\_security\_group\_id) | The ID of the ALB security group |
| <a name="output_ec2_security_group_arn"></a> [ec2\_security\_group\_arn](#output\_ec2\_security\_group\_arn) | The ARN of the EC2 security group |
| <a name="output_ec2_security_group_id"></a> [ec2\_security\_group\_id](#output\_ec2\_security\_group\_id) | The ID of the EC2 security group |
| <a name="output_rds_security_group_arn"></a> [rds\_security\_group\_arn](#output\_rds\_security\_group\_arn) | The ARN of the RDS security group |
| <a name="output_rds_security_group_id"></a> [rds\_security\_group\_id](#output\_rds\_security\_group\_id) | The ID of the RDS security group |
| <a name="output_security_group_arns"></a> [security\_group\_arns](#output\_security\_group\_arns) | Map of security group ARNs |
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | Map of security group IDs |
<!-- END_TF_DOCS -->