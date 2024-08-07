
variable "vpc_cidr" {
    description = "The vpc cidr using use /16 or /8"
   //default = "172.120.0.0/16"
   type = string
   validation {
     condition = tonumber(split("/",var.vpc_cidr)[1]) == 16 || tonumber(split("/",var.vpc_cidr)[1]) == 8
     error_message = "Error: your vpc cidr is not valid. Use /16 or /8 instead"
   }
}
variable "nbr_pub_sub_blocks" {
  description = "Number of public subnets.Your private subnets must be between 1 and 4"
  //default = 1
  type = number
   validation {
     condition = var.nbr_pub_sub_blocks >= 1 && var.nbr_pub_sub_blocks < 5
     error_message = "Error: the number of public subnets must be between 1 and 4" 
   }
}
variable "nbr_prv_sub_blocks" {
  description = "Number of private subnets.Your private subnets must be at least equal 0"
  //default = 3
  type = number
     validation {
     condition = var.nbr_prv_sub_blocks >= 0 
     error_message = "Error: the number of private subnets must be at least equal 0 " 
   }
}
variable "nbr_azs" {
  description = "Number of availability zones. Your availability zones must be less than 5"
  //default = 2
  type = number
   validation {
     condition = var.nbr_azs >= 1 && var.nbr_azs < 5
     error_message = "Error: the number of availability zones must be less than 5" 
   }
}
variable "costum_az" {
  default = false
}

variable "type_nat_gateway" {
  description = "Your nat gateway must be either '1 in AZ' or '1 per AZ'"
  type = string
  default = "1 per AZ"
   validation {
     condition = var.type_nat_gateway == "1 in AZ" || var.type_nat_gateway == "1 per AZ"
     error_message = "Error: your nat gateway is not supported.Your choice must be either '1 in AZ' or '1 per AZ'"
   }
}

variable "enable_dns_hostnames" {
  type    = bool
}

variable "enable_dns_support" {
  type    = bool
}

variable "tag_environment" { type = string }
variable "internet_gw" {}
variable "tag_vpc_name" {}
variable "region" {
  type = string
}