resource "aws_codedeploy_app" "app" {
    name                    = var.NAME
}

resource "aws_s3_bucket" "bucket" {
    bucket                  = var.BUCKET
}

resource "aws_codedeploy_deployment_group" "group" {
    deployment_group_name   = "${aws_codedeploy_app.app.name}-group"
    app_name                = aws_codedeploy_app.app.name

    service_role_arn        = var.SERVICE_ROLE
    autoscaling_groups      = var.ASG

    auto_rollback_configuration {
        enabled             = var.ROLLBACK
        events              = var.ROLLBACK_EVENTS
    }
}