# S3 Module

Este módulo crea un bucket S3 con configuraciones de seguridad, versioning, encriptación y lifecycle rules para almacenar archivos estáticos de la aplicación NotesApp.

## Características

- **S3 Bucket**: Configurado para archivos estáticos
- **Versioning**: Habilitado para control de versiones
- **Encriptación**: Server-side encryption con AES256
- **Public Access Block**: Bloqueo de acceso público por defecto
- **Lifecycle Rules**: Gestión automática de versiones antiguas
- **CORS Configuration**: Configurado para acceso web
- **Bucket Policy**: Política básica para CloudFront (opcional)
- **Notifications**: Configuración para Lambda, SQS y SNS (opcional)

## Uso

```hcl
module "s3" {
  source = "./modules/s3"

  environment = "dev"
  bucket_name = "notesapp-static-files-dev"
  
  common_tags = {
    Project     = "NotesApp"
    ManagedBy   = "Terraform"
    Environment = "dev"
  }
}
```

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
| [aws_s3_bucket_versioning.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_public_access_block.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_lifecycle_configuration.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_cors_configuration.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_cors_configuration) | resource |
| [aws_s3_bucket_notification.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |
| [aws_s3_bucket_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name of the S3 bucket (must be globally unique) | `string` | `"notesapp-static-files"` | no |
| <a name="input_bucket_versioning"></a> [bucket\_versioning](#input\_bucket\_versioning) | Enable versioning for the S3 bucket | `bool` | `true` | no |
| <a name="input_bucket_encryption"></a> [bucket\_encryption](#input\_bucket\_encryption) | Enable server-side encryption for the S3 bucket | `bool` | `true` | no |
| <a name="input_bucket_public_access_block"></a> [bucket\_public\_access\_block](#input\_bucket\_public\_access\_block) | Block public access to the S3 bucket | `bool` | `true` | no |
| <a name="input_bucket_lifecycle_rules"></a> [bucket\_lifecycle\_rules](#input\_bucket\_lifecycle\_rules) | Lifecycle rules for the S3 bucket | `list(object({...}))` | <pre>[<br/>  {<br/>    "id": "delete-old-versions",<br/>    "enabled": true,<br/>    "prefix": "",<br/>    "noncurrent_version_expiration": {<br/>      "noncurrent_days": 30<br/>    },<br/>    "abort_incomplete_multipart_upload": {<br/>      "days_after_initiation": 7<br/>    }<br/>  }<br/>]</pre> | no |
| <a name="input_bucket_cors_rules"></a> [bucket\_cors\_rules](#input\_bucket\_cors\_rules) | CORS rules for the S3 bucket | `list(object({...}))` | <pre>[<br/>  {<br/>    "allowed_headers": ["*"],<br/>    "allowed_methods": ["GET", "PUT", "POST", "DELETE", "HEAD"],<br/>    "allowed_origins": ["*"],<br/>    "expose_headers": ["ETag"],<br/>    "max_age_seconds": 3000<br/>  }<br/>]</pre> | no |
| <a name="input_bucket_notification_configuration"></a> [bucket\_notification\_configuration](#input\_bucket\_notification\_configuration) | Notification configuration for the S3 bucket | `object({...})` | `null` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common tags to apply to all resources | `map(string)` | <pre>{<br/>  "Environment": "dev",<br/>  "ManagedBy": "Terraform",<br/>  "Project": "NotesApp"<br/>}</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name for resource tagging | `string` | `"dev"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | The name of the S3 bucket |
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | The ARN of the S3 bucket |
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | The bucket domain name |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | The bucket region-specific domain name |
| <a name="output_bucket_region"></a> [bucket\_region](#output\_bucket\_region) | The AWS region this bucket resides in |
| <a name="output_bucket_website_endpoint"></a> [bucket\_website\_endpoint](#output\_bucket\_website\_endpoint) | The website endpoint, if the bucket is configured with a website |
| <a name="output_bucket_website_domain"></a> [bucket\_website\_domain](#output\_bucket\_website\_domain) | The domain of the website endpoint, if the bucket is configured with a website |
| <a name="output_bucket_versioning_status"></a> [bucket\_versioning\_status](#output\_bucket\_versioning\_status) | The versioning status of the bucket |
| <a name="output_bucket_encryption_algorithm"></a> [bucket\_encryption\_algorithm](#output\_bucket\_encryption\_algorithm) | The server-side encryption algorithm used by the bucket |
| <a name="output_bucket_public_access_blocked"></a> [bucket\_public\_access\_blocked](#output\_bucket\_public\_access\_blocked) | Whether public access is blocked for this bucket |
| <a name="output_bucket_lifecycle_rules"></a> [bucket\_lifecycle\_rules](#output\_bucket\_lifecycle\_rules) | The lifecycle rules configured for the bucket |
| <a name="output_bucket_cors_rules"></a> [bucket\_cors\_rules](#output\_bucket\_cors\_rules) | The CORS rules configured for the bucket |

## Configuración de Seguridad

### ✅ **Buenas prácticas implementadas:**
- **Encriptación**: Server-side encryption con AES256
- **Public Access Block**: Bloqueo completo de acceso público
- **Versioning**: Control de versiones para recuperación de datos
- **Lifecycle Rules**: Gestión automática de versiones antiguas
- **CORS**: Configuración para acceso web seguro

### 🔒 **Configuración de acceso:**
- **Public Access**: Bloqueado por defecto
- **Bucket Policy**: Solo acceso desde CloudFront (si se configura)
- **Encriptación**: AES256 por defecto
- **Versioning**: Habilitado para control de versiones

### 📊 **Lifecycle Rules por defecto:**
- **Versiones antiguas**: Eliminadas después de 30 días
- **Multipart uploads**: Abortados después de 7 días
- **Aplicable a**: Todo el bucket (prefix vacío)

### 🌐 **CORS Configuration:**
- **Métodos permitidos**: GET, PUT, POST, DELETE, HEAD
- **Headers permitidos**: Todos (*)
- **Orígenes permitidos**: Todos (*) - configurar específicamente en producción
- **Max Age**: 3000 segundos

## Notas importantes

- **Nombre único**: El nombre del bucket debe ser globalmente único
- **Public Access**: Bloqueado por defecto por seguridad
- **Encriptación**: Habilitada por defecto
- **Versioning**: Habilitado para control de versiones
- **Lifecycle**: Configurado para limpiar versiones antiguas automáticamente
- **CORS**: Configurado para acceso web, ajustar orígenes en producción
