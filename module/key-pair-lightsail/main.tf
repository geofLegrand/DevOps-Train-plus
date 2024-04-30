resource "aws_lightsail_key_pair" "lg_key_pair" {
  name = var.key_name
}

variable "key_name" {
   
}

output "output_key_name" {
   value = aws_lightsail_key_pair.lg_key_pair.name
}