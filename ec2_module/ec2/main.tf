resource "aws_instance" "docker_server" {
  ami           = var.ami
  instance_type = var.instance_type
  user_data     = var.user_data
  key_name = var.key_name
  iam_instance_profile = var.iam_instance_profile
  
  tags = {
    Name : var.tags_name

  }
}

