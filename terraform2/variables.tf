variable "region" {
  type    = string
  default = "us-west-2"
}

variable "eb_app_name" {
  description = "The name of the Elastic Beanstalk app"
  type        = string
  default = "best-vulpy"
}