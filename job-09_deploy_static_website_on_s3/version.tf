terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }
  }
  # backend "s3" {
    
  # }
}

# Configure the AWS Provider

provider "aws" {
  alias = "acm_provider"
  region = "us-east-1"
}