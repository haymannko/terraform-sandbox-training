
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

//count
resource "aws_subnet" "base_subnets" {
    count = length(var.subnet_name)
    vpc_id = aws_vpc.base_vpc.id
    cidr_block =  var.subnet_name[count.index].cidr_block//10.0.1.0/24
    map_public_ip_on_launch = true
    availability_zone = var.subnet_name[count.index].availability_zone //ap-southeast-1a
    tags = {
      Name = "${local.vpc_name}-${var.subnet_name[count.index].Name}"
    }
 
}

resource "aws_route_table" "base_RT" {
  vpc_id = aws_vpc.base_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.base_igw.id
  }
  tags = {
    Name = var.RT_name
  }

  
}

resource "aws_route_table_association" "base_RT_ASSO" {
  count = length(aws_subnet.base_subnets)
  route_table_id = aws_route_table.base_RT.id
  subnet_id = aws_subnet.base_subnets[count.index].id
  
}


