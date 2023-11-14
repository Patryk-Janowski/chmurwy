data "aws_caller_identity" "current" {}

resource "aws_iam_role" "eb_ec2_role" {
  name = "eb-ec2-role-${local.app_name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "smm_attachment" {
  role       = aws_iam_role.eb_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


resource "aws_iam_instance_profile" "eb_instance_profile" {
  name = "eb-instance-profile-${local.app_name}"
  role = aws_iam_role.eb_ec2_role.name
}


resource "aws_iam_role_policy_attachment" "tmp_eb_attach" {
  role       = aws_iam_role.eb_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

