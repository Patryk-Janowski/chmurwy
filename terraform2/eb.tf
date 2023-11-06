resource "aws_elastic_beanstalk_application" "best-vulpy-app" {
  name = local.app_name # The name of your existing Elastic Beanstalk application
}

# import {
#   id = "best-vulpy"
#   to = aws_elastic_beanstalk_application.best-vulpy-app
# }

data "external" "latest_python_stack" {
  program = ["./get_latest_solution_stack.sh"]
}

resource "aws_elastic_beanstalk_environment" "best-vulpy-env" {
  name                = "${local.app_name}-env" # The name of your existing Elastic Beanstalk environment
  application         = aws_elastic_beanstalk_application.best-vulpy-app.name
  solution_stack_name = data.external.latest_python_stack.result["latest_solution_stack_name"]


  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.eb_instance_profile.name
  }
}
