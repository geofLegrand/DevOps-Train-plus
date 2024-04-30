resource "aws_security_group" "rds_mysql_sg" {
  name        = "rds-sg"
  description = "Allow access"
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = var.ports
    content {
       from_port   = ingress.value.from_port
       to_port     = ingress.value.to_port
       protocol    = ingress.value.protocol
       cidr_blocks = ingress.value.cidr_blocks
       security_groups = ingress.value.sec_sg
    }
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  tags = {
    Name = ""
    Environment = ""
  }
}


variable "ports" {
  
}

variable "tags_name" {
  
}

variable "tags_env" {
  
}

data "aws_vpc" "default_vpc" {}
variable "vpc_id" {
   
}

