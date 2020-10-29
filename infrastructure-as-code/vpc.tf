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

####

resource "aws_subnet" "public_subnet" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.PUBLIC_SUBNET_CIDR
    map_public_ip_on_launch = var.PUBLIC_SUBNET_MAP_IP
    availability_zone       = var.PUBLIC_SUBNET_AZ
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

####

resource "aws_nat_gateway" "ngw" {
    allocation_id   = aws_eip.nat_eip.id
    subnet_id       = aws_subnet.public_subnet.id
    depends_on      = [aws_internet_gateway.igw]
}

####

resource "aws_subnet" "private_subnet" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.PRIVATE_SUBNET_CIDR
    availability_zone       = var.PRIVATE_SUBNET_AZ
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

####

resource "aws_subnet" "backup_subnet" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.BACKUP_SUBNET_CIDR
    availability_zone       = var.BACKUP_SUBNET_AZ
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

