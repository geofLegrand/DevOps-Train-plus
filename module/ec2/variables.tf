
 variable "user_data" {
    default = ""
 }

  variable "ami" {
    default = "ami-0a699202e5027c10d"
  }
   variable "instance_type" {
    default = "t2.micro"
  }
   variable "key_name" {
    default = "my-key"
  }
   variable "tags_name" {
     default = "Docker_Server"
  }
variable "availability_zone" {
   default = "us-east-1a"
}
variable "default_subnet" {
   default = "subnet-01a922d4a86654626"
}
variable "default_vpc_sg" {
   default = "sg-0be779bbb0a1ca2f8"
}
variable "give_public_ip_address" {
  default = true
}