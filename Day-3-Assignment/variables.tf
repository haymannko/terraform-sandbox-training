variable "vpc_name" {
  default = "test-vpc"

}

variable "vpc_cidr" {
  default = "10.0.0.0/16"


}

variable "zone_for_subnets" {
  type    = list(string)
  default = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]

}

//default->user input
//default = ""
//terraform apply --var vpc_name="cloud_vpc"
//terraform apply --var-file=production.tfvars


//               0            1             2
//zone        =>1a            1b            1c
//cidr        =>10.0.0.0/24   10.0.1.0/24   10.0.2.0/24
//subnet name =>subnet1       subnet2       subnet3



variable "cidr_for_subnets" {
    type = list(string)
    default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "cidr_for_privatesubnets" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]

}

variable "name_for_subnets" {
    type = list(string)
    default = ["publicsubnet1", "publicsubnet2", "publicsubnet3"]
}

variable "name_for_privatesubnets" {
  type    = list(string)
  default = ["privatesubnet1", "privatesubnet2", "privatesubnet3"]
}

# variable "public_subnets" {
#   type = map(object({
#     cidr = string
#     zone = string
#     Name = string
#   }))
#   default = {
#     "public_subnet_1" = {
#       cidr = "10.0.0.0/24"
#       zone = "ap-southeast-1a"
#       Name = "publicsubnet1"

#     },
#     "public_subnet_2" = {
#       cidr = "10.0.1.0/24"
#       zone = "ap-southeast-1b"
#       Name = "publicsubnet2"

#     },
#     "public_subnet_3" = {
#       cidr = "10.0.2.0/24"
#       zone = "ap-southeast-1c"
#       Name = "publicsubnet3"

#     },
#   }

# }