
// Install docker on my default vpc
module "my_docker" {
  source = "../module/ec2"
  ami = "ami-0a699202e5027c10d"
  instance_type = "t2.micro"
  key_name = "my-key"
  tags_name = "Docker_server"
  user_data =   file("install_docker.sh")
  give_public_ip_address = true
}


# // Install 
# module "rds" {
#   source = "../module/rds"
#     allocated_storage       = 10
#   storage_type            = "gp2"
#   engine                  = "mysql"
#   engine_version          = "5.7"
#   instance_class          = "db.t2.micro"
#   identifier              = "mydb"
#   username                = "admin"
#   password                = "devopstrain123"
#   vpc_security_group_ids  = ""
#   db_subnet_group_name    = ""
#   db_name                 = "webdb"
#   skip_final_snapshot     = true
#   apply_immediately       = true
#   backup_retention_period = 0
#   deletion_protection     = false
# }

# data "aws_v" "name" {
  
# }


module "ec2" {

  source = ".."
  
}