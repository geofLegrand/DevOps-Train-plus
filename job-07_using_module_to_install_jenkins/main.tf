terraform {
   required_providers {
     aws = {
       source = "hashicorp/aws"
       version = "4.61.0"
     }
   }
}   

provider "aws" {
   region = "us-east-1"
}
module "my_jenkins" {
  source               = "../ec2_module/ec2"
  ami                  = "ami-0a699202e5027c10d"
  instance_type        = "t2.micro"
  key_name             = "my-key"
  tags_name            = "jenkins-serv"
  user_data            = file("install_jenkins.sh")
  //iam_instance_profile = aws_iam_instance_profile.myprofile.name


}