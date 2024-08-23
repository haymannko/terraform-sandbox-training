#create vpc
#create internet gateway
#create internet gateway to vpc
#create one public subnet per each zone
#create a public routing table and associate it with all public subnets



# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

#VPC
resource "aws_vpc" "nonprod-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }

}


#IGW
resource "aws_internet_gateway" "igw" {
  tags = {
    Name = "test-igw"
  }

}

resource "aws_internet_gateway_attachment" "igw_vpc" {
  internet_gateway_id = aws_internet_gateway.igw.id
  vpc_id              = aws_vpc.nonprod-vpc.id

}

#Route Table
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.nonprod-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "my_public_rtb"
  }
}



//subnets
//for each and count



#public subnets
resource "aws_subnet" "nonprod-publicsubnets" {
  count = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.nonprod-vpc.id
  cidr_block = var.cidr_for_subnets[count.index]
  availability_zone = var.zone_for_subnets[count.index]
    tags = {
    Name = var.name_for_subnets[count.index]
  }

}


# resource "aws_subnet" "nonprod-publicsubnets" {
#   for_each                = var.public_subnets //map(object) -> 3
#   vpc_id                  = aws_vpc.nonprod-vpc.id
#   cidr_block              = each.value.cidr //10.0.0.0/24
#   map_public_ip_on_launch = true
#   availability_zone       = each.value.zone //ap-southeast-1a
#   tags = {
#     Name = "${local.vpc_name}-${each.value.Name}" // VPC-A-Public-Subnet-1
#   }

# }



#private subnets
resource "aws_subnet" "nonprod-privatesubnets" {
  count             = length(data.aws_availability_zones.available.names)
  vpc_id            = aws_vpc.nonprod-vpc.id
  cidr_block        = var.cidr_for_privatesubnets[count.index]
  availability_zone = var.zone_for_subnets[count.index]
  tags = {
    Name = var.name_for_privatesubnets[count.index]
  }

}



resource "aws_route_table_association" "pub_rtb_subnets" {
  count          = length(aws_subnet.nonprod-publicsubnets)
  route_table_id = aws_route_table.public_rtb.id
  subnet_id      = aws_subnet.nonprod-publicsubnets[count.index].id

}

#resource "aws_subnet" "nonprod-subnet2" {
#    vpc_id = aws_vpc.nonprod-vpc.id
#    cidr_block = "10.0.1.0/24"
#    availability_zone = "ap-southeast-1b"
#    tags = {
#      Name = "subnet2"
#    }

#}

#resource "aws_subnet" "nonprod-subnet3" {
#    vpc_id = aws_vpc.nonprod-vpc.id
#    cidr_block = "10.0.2.0/24"
#    availability_zone = "ap-southeast-1c"
#    tags = {
#      Name = "subnet3"
#    }

#}