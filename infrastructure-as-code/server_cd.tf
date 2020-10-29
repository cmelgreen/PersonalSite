resource "aws_codedeploy_app" "server_cd_app" {
    name                    = "server_cd_app"
}

resource "aws_iam_instance_profile" "server_cd_iam_profile" {
    role = aws_iam_role.server_cd_iam_role.name
}

resource "aws_iam_role" "server_cd_iam_role" {
    name                = "server_cd_iam_role"

    assume_role_policy  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
          "Service": [
          "ec2.amazonaws.com"
          ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_s3_bucket" "server_cd_bucket" {
  bucket = "server-s3-bucket"
}

resource "aws_iam_role_policy_attachment" "server_iam_codedeploy_deployer" {
    policy_arn              = "arn:aws:iam::aws:policy/AWSCodeDeployDeployerAccess"
    role                    = aws_iam_role.server_cd_iam_role.name
}

resource "aws_iam_role_policy_attachment" "server_iam_codedeploy" {
    policy_arn              = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
    role                    = aws_iam_role.server_cd_iam_role.name
}

resource "aws_iam_role_policy_attachment" "server_cd_iam_full_ssm" {
    policy_arn  = var.IAM_FULL_SSM_ARN
    role        = aws_iam_role.server_cd_iam_role.name
}

resource "aws_iam_role_policy_attachment" "server_iam_s3" {
    policy_arn              = var.IAM_FULL_S3_ARN
    role                    = aws_iam_role.server_cd_iam_role.name
}

resource "aws_codedeploy_deployment_group" "server_cd_group" {
    deployment_group_name   = "server_cd_group"
    app_name                = aws_codedeploy_app.server_cd_app.name

    service_role_arn        = aws_iam_role.server_cd_iam_role.arn
    autoscaling_groups      = [aws_autoscaling_group.server_asg.name]

    auto_rollback_configuration {
        enabled             = true
        events              = ["DEPLOYMENT_FAILURE"]
    }
}