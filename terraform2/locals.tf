locals {
  app_name   = "${var.eb_app_name}-${random_string.suffix.id}"
  account_id = data.aws_caller_identity.current.account_id
}

resource "random_string" "suffix" {
  length  = 8
  upper   = false
  special = false
}
