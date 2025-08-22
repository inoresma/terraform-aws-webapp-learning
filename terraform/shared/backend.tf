#### Guardar el estado de terraform en AWS S3 ####
terraform {
    backend "s3" {
        bucket = "s3-terraform-practice-inoresma"
        key = "terraform-tfstate/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        #dynamodb_table = "terraform-locks"

    }
}

