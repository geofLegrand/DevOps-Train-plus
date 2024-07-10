terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.61.0"
    }
  }
  backend "s3" {
    bucket = "value"
    key = "value"
    region = "value"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
