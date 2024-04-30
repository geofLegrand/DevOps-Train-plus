provider "aws" {
    region = "us-east-1"
  
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  backup_retention_period = 0
  apply_immediately = true
  identifier = "dev-database2"

#   lifecycle {
#     create_before_destroy = false
#   }

}

// terraform apply -auto-apply -var-file=secret
