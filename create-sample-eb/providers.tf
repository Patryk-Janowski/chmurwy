provider "aws" {
  region  = var.region
  profile = "default"
}

provider "tls" {}

provider "random" {}

