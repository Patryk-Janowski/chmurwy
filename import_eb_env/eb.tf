resource "aws_elastic_beanstalk_environment" "hehe" {
  application = "best-vulpy-hr7lubkw"
  name = "best-vulpy-hr7lubkw-env"
}

import {
  id = "e-rghtse7qiv"
  to = aws_elastic_beanstalk_environment.hehe
}