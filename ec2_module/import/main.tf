 terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.61.0"
    }

  }
}
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


 
 import {
   id = "i-02730e30ad4575126"
   to = aws_instance.ec2_instance
 }