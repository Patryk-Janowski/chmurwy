provider "aws" {
  region  = var.region
  profile = "default"
}

provider "tls" {}

provider "random" {}

terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-gqo9293j"
    key            = "create-sample-eb/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-lock-table-gqo9293j"
    encrypt        = true
  }
}