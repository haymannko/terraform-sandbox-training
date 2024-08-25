output "my_zones" {
    value = data.aws_availability_zones.available.names
  
}

output "vpc_name" {
    value = "My VPC name is ${aws_vpc.base_vpc.tags.Name}"
  
}

output "igw_name" {
    value = "My IGW name is ${aws_internet_gateway.base_igw.tags.Name}"
  
}

