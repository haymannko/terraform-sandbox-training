variable "base_vpc" {
    type = object({
      Name = string
      cidr = string
    })
      default = {
        Name = "VPC-A"
        cidr = "10.0.0.0/16"
      }
  
}


variable "base_igw" {
    type = object({
      Name = string
    })
      default = {
        Name = "VPC-A-IGW"
      }
  
}


//list of objects
//list, set -> default =[]
//map -> default = {"key" = {}, "key" = {}, "key" = {}}

variable "subnet_name" {
    type = map(object({
      cidr_block = string
      availability_zone= string
      Name = string
    }))
      default = {
        "Subnet-1" = {
        cidr_block = "10.0.1.0/24"
        availability_zone = "ap-southeast-1a"
        Name = "Subnet-1"
      },
      "Subnet-2" = {
        cidr_block = "10.0.2.0/24"
        availability_zone = "ap-southeast-1b"
        Name = "Subnet-2"
      },
      "Subnet-3" ={
        cidr_block = "10.0.3.0/24"
        availability_zone = "ap-southeast-1c"
        Name = "Subnet-3"
      }}
  
}
