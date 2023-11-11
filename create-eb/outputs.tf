output "app_name" {
  value = local.app_name
}

output "eb_env_id" {
  value = aws_elastic_beanstalk_environment.best-vulpy-env.id
}