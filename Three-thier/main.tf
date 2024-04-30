resource "random_id" "randomnes" {
   byte_length = 16
}
resource "aws_instance" "web_server" {
  ami           = var.ami
  instance_type = var.size
  user_data     = file(var.script)
  //key_name      = aws_key_pair.ec2_key.key_name
  count = length(var.private_subnet_blocks)
  vpc_security_group_ids = [aws_security_group.srv_sg.id]
  subnet_id              = aws_subnet.private_subnets_az[count.index].id
  availability_zone      = var.availability_zone[count.index]

  tags = {

    Name : "my_server_az${count.index}"

  }

}


