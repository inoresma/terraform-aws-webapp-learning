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
| [aws_s3_bucket.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_cors_configuration.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_cors_configuration) | resource |
| [aws_s3_bucket_lifecycle_configuration.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_cors_rules"></a> [bucket\_cors\_rules](#input\_bucket\_cors\_rules) | CORS rules for the S3 bucket | <pre>list(object({<br/>    allowed_headers = list(string)<br/>    allowed_methods = list(string)<br/>    allowed_origins = list(string)<br/>    expose_headers  = list(string)<br/>    max_age_seconds = number<br/>  }))</pre> | <pre>[<br/>  {<br/>    "allowed_headers": [<br/>      "*"<br/>    ],<br/>    "allowed_methods": [<br/>      "GET",<br/>      "PUT",<br/>      "POST",<br/>      "DELETE",<br/>      "HEAD"<br/>    ],<br/>    "allowed_origins": [<br/>      "*"<br/>    ],<br/>    "expose_headers": [<br/>      "ETag"<br/>    ],<br/>    "max_age_seconds": 3000<br/>  }<br/>]</pre> | no |
| <a name="input_bucket_encryption"></a> [bucket\_encryption](#input\_bucket\_encryption) | Enable server-side encryption for the S3 bucket | `bool` | `true` | no |
| <a name="input_bucket_lifecycle_rules"></a> [bucket\_lifecycle\_rules](#input\_bucket\_lifecycle\_rules) | Lifecycle rules for the S3 bucket | <pre>list(object({<br/>    id      = string<br/>    enabled = bool<br/>    prefix  = string<br/>    <br/>    expiration = optional(object({<br/>      days = number<br/>    }))<br/>    <br/>    noncurrent_version_expiration = optional(object({<br/>      noncurrent_days = number<br/>    }))<br/>    <br/>    abort_incomplete_multipart_upload = optional(object({<br/>      days_after_initiation = number<br/>    }))<br/>  }))</pre> | <pre>[<br/>  {<br/>    "abort_incomplete_multipart_upload": {<br/>      "days_after_initiation": 7<br/>    },<br/>    "enabled": true,<br/>    "id": "delete-old-versions",<br/>    "noncurrent_version_expiration": {<br/>      "noncurrent_days": 30<br/>    },<br/>    "prefix": ""<br/>  }<br/>]</pre> | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name of the S3 bucket (must be globally unique) | `string` | `"notesapp-static-files-inoresma"` | no |
| <a name="input_bucket_public_access_block"></a> [bucket\_public\_access\_block](#input\_bucket\_public\_access\_block) | Block public access to the S3 bucket | `bool` | `true` | no |
| <a name="input_bucket_versioning"></a> [bucket\_versioning](#input\_bucket\_versioning) | Enable versioning for the S3 bucket | `bool` | `true` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common tags to apply to all resources | `map(string)` | <pre>{<br/>  "Environment": "dev",<br/>  "ManagedBy": "Terraform",<br/>  "Project": "NotesApp"<br/>}</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name for resource tagging | `string` | `"dev"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_cors_rules"></a> [bucket\_cors\_rules](#output\_bucket\_cors\_rules) | The CORS rules configured for the bucket |
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | The bucket domain name |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | The name of the S3 bucket |
| <a name="output_bucket_public_access_blocked"></a> [bucket\_public\_access\_blocked](#output\_bucket\_public\_access\_blocked) | Whether public access is blocked for this bucket |
| <a name="output_bucket_region"></a> [bucket\_region](#output\_bucket\_region) | The AWS region this bucket resides in |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | The bucket region-specific domain name |
<!-- END_TF_DOCS -->