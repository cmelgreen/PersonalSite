module "build_server" {
    source          = "./networked_ec2"

    NAME            = "build_server"

    ## Filter AMI better instead of hardcode
    AMI             = "ami-04ddade76a44c06c3"
    USER_DATA       = file("scripts/build_server.sh")
    INSTANCE_TYPE   = "t2.small"
    PUBLIC_IP       = true
    KEY             = "zoff.pem"
    SUBNET          = 
    VPC_SG_IDS      = 
    IAM_BASE_POLICY = var.EC2_CODEDEPLOY_POLICY
    IAM_POLICIES    = [
        var.IAM_CD_DEPLOYER_ARN,
        var.IAM_CD_DEPLOY_ARN,
        var.IAM_FULL_SSM_ARN,
        var.IAM_FULL_S3_ARN
    ]
}

module "deployment_server_group" {
    source          = "./networked_asg"

    NAME            = "deploymnet_server_group"
    IMAGE           = "ami-04ddade76a44c06c3"
    USER_DATA       = file("scripts/deployment_server.sh")
    VPC             = 
    LC_SG           =
    KEY             = "zoff.pem"

    PUBLIC_IP       = false
    ELB_SG          =
    ELB_SUBNETS     = 


    IAM_POLICIES    = [
        var.IAM_CD_EC2_ARN,
        var.IAM_FULL_SSM_ARN
    ]
}

resource "github_repository_webhook" "github_webhook" {
    repository = var.GITHUB_REPO

    configuration {
        url          = "http://${aws_instance.build_server.public_ip}/github-webhook/"
        content_type = var.GITHUB_CONTENT_TYPE
        insecure_ssl = var.GITHUB_INSECURE_SSL
    }

    events = var.GITHUB_EVENTS
}