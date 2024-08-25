
data "aws_availability_zones" "available" {
    state = "available"
  
}

resource "aws_vpc" "base_vpc" {
    cidr_block = var.base_vpc.cidr //10.0.0.0/16
    tags = {
      Name = var.base_vpc.Name//VPC-A
    }
  
}


locals {
  vpc_name = aws_vpc.base_vpc.tags.Name
}

resource "aws_internet_gateway" "base_igw" {
    vpc_id = aws_vpc.base_vpc.id
    tags = {
      Name = var.base_igw.Name //VPC-A-IGW
    }
  
}

//each
resource "aws_subnet" "base_subnets" {
    for_each = var.subnet_name //map(object)=>3
    vpc_id = aws_vpc.base_vpc.id
    cidr_block =  each.value.cidr_block//10.0.1.0/24
    map_public_ip_on_launch = true
    availability_zone = each.value.availability_zone //ap-southeast-1a
    tags = {
      Name = "${local.vpc_name}-${each.value.Name}"
    }
 
}


