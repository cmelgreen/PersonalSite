provider "aws" {
    region = var.AWS_REGION
}

provider "github" {
	token = file(var.GITHUB_CREDENTIALS)
	owner = var.GITHUB_OWNER
}

module "build_server" {
    source          = "./modules/networked_ec2"

    ## Filter AMI better instead of hardcode
    AMI             = var.BUILD_SERVER_AMI
    USER_DATA       = file(var.BUILD_SERVER_USER_DATA)
    INSTANCE_TYPE   = var.BUILD_SERVER_INSTANCE
    KEY             = var.BUILD_SERVER_KEY

    SUBNET          = aws_subnet.public_subnet.id
    VPC_SG_IDS      = [aws_security_group.public_http_sg.id]

    # Use data sources instead of vars
    IAM_BASE_POLICY = var.EC2_CODEDEPLOY_POLICY
    IAM_POLICIES    = [
        var.IAM_CD_DEPLOYER_ARN,
        var.IAM_CD_DEPLOY_ARN,
        var.IAM_FULL_SSM_ARN,
        var.IAM_FULL_S3_ARN
    ]
}

module "deployment_server_group" {
    source          = "./modules/networked_asg"

    NAME            = var.DEPLOYMENT_GROUP_NAME
    AMI             = var.DEPLOYMENT_GROUP_AMI
    USER_DATA       = templatefile(var.DEPLOYMENT_GROUP_USER_DATA, {region = var.AWS_REGION})
    KEY             = var.DEPLOYMENT_GROUP_KEY
    VPC_ZONE_ID     = [aws_subnet.private_subnet.id]
    LC_SG           = [aws_security_group.public_http_sg.id]

    ELB_SUBNETS     = [aws_subnet.private_subnet.id]
    ELB_SG          = [aws_security_group.public_http_sg.id]

    IAM_POLICIES    = [
        var.IAM_CD_EC2_ARN,
        var.IAM_FULL_SSM_ARN
    ]
}

module "database" {
    source          = "./modules/db_with_ssm_credentials"

    IDENTIFIER      = var.DB_IDENTIFIER
    USERNAME        = var.DB_USERNAME
    PASSWORD        = file(var.DB_PASSWORD)

    VPC             = aws_vpc.vpc.id
    INGRESS_SGS     = [aws_security_group.public_http_sg.id]
    SUBNETS         = [
        aws_subnet.private_subnet.id,
        aws_subnet.backup_subnet.id
    ]
}

module "codedeploy_app" {
    source          = "./modules/codedeploy_app"

    NAME            = var.CODEDEPLOY_NAME
    BUCKET          = var.CODEDEPLOY_BUCKET
    GROUP_NAME      = var.CODEDEPLOY_GROUP_NAME
    ASG             = [module.deployment_server_group.asg.name]
    SERVICE_ROLE    = module.build_server.iam_role.arn
}

resource "aws_vpc" "vpc" {
    cidr_block              = var.VPC_CIDR
    enable_dns_support      = var.VPC_DN_SUPPORT
    enable_dns_hostnames    = var.VPC_DNS_HOSTNAMES
}

resource "aws_internet_gateway" "igw" {
    vpc_id          = aws_vpc.vpc.id
}

resource "aws_eip" "nat_eip" {
    vpc             = true
    depends_on      = [aws_internet_gateway.igw]
}

resource "aws_subnet" "public_subnet" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.PUBLIC_SUBNET_CIDR
    map_public_ip_on_launch = var.PUBLIC_SUBNET_MAP_IP
    availability_zone       = var.AWS_AZ
}

resource "aws_route_table" "public_rtb" {
    vpc_id          = aws_vpc.vpc.id

    route {
        cidr_block  = "0.0.0.0/0"
        gateway_id  = aws_internet_gateway.igw.id
    }
}

resource "aws_route_table_association" "rta_subnet_public" {
    route_table_id  = aws_route_table.public_rtb.id
    subnet_id       = aws_subnet.public_subnet.id
}

resource "aws_nat_gateway" "ngw" {
    allocation_id   = aws_eip.nat_eip.id
    subnet_id       = aws_subnet.public_subnet.id
    depends_on      = [aws_internet_gateway.igw]
}

resource "aws_subnet" "private_subnet" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.PRIVATE_SUBNET_CIDR
    availability_zone       = var.AWS_AZ
}

resource "aws_route_table" "private_rtb" {
    vpc_id          = aws_vpc.vpc.id

    route {
        cidr_block  = "0.0.0.0/0"
        gateway_id  = aws_nat_gateway.ngw.id
    }
}

resource "aws_route_table_association" "private_subnet" {
    subnet_id      = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_rtb.id
}

resource "aws_subnet" "backup_subnet" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.BACKUP_SUBNET_CIDR
    availability_zone       = var.AWS_BACKUP_AZ
}

resource "aws_route_table" "backup_rtb" {
    vpc_id          = aws_vpc.vpc.id

    route {
        cidr_block  = "0.0.0.0/0"
        gateway_id  = aws_nat_gateway.ngw.id
    }
}

resource "aws_route_table_association" "backup_subnet" {
    subnet_id      = aws_subnet.backup_subnet.id
    route_table_id = aws_route_table.backup_rtb.id
}


resource "aws_security_group" "public_http_sg" {
	name        = "public_http_sg"

    vpc_id = aws_vpc.vpc.id

    ingress { 
        from_port   = 22    
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

	ingress {
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}