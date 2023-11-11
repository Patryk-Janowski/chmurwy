resource "random_string" "suffix" {
  length  = 8
  upper   = false
  special = false
}


resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-bucket-${random_string.suffix.id}"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  # New way to enable server-side encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}



terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "path/to/my/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "my-terraform-lock-table"
    encrypt        = true
  }
}

