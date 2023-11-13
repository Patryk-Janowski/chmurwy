output "app_name" {
  value = local.app_name
}

output "eb_env_id" {
  value = aws_elastic_beanstalk_environment.best-vulpy-env.id
}

output "eb_role_name" {
  value = aws_iam_role.eb_ec2_role.name
}
