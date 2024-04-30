terraform {
  required_version = ">= 1.0.0"
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
variable "list_of_servers" {
    default = [
      "i-0a7a5cc01526baf24"
   ]
}

	


data "aws_instance" "ec2" {
    count =length(var.list_of_servers)
    instance_id =var.list_of_servers[count.index]  #
    //instance_id = var.list_of_servers
    
}


resource "null_resource" "my_data" {
  ################################ Third method ######################################
    count =length(var.list_of_servers)
    provisioner "local-exec" {
      command = <<-EOT
          
          echo "public_ip = ${data.aws_instance.ec2[count.index].instance_id}_${data.aws_instance.ec2[count.index].public_ip}" >> project.txt
          echo "private_ip = ${data.aws_instance.ec2[count.index].instance_id}_${data.aws_instance.ec2[count.index].private_ip}" >> project.txt
          echo "public_dns = ${data.aws_instance.ec2[count.index].instance_id}_${data.aws_instance.ec2[count.index].public_dns}" >> project.txt
          echo "private_dns = ${data.aws_instance.ec2[count.index].instance_id}_${data.aws_instance.ec2[count.index].private_dns}" >> project.txt
          echo "key_name = ${data.aws_instance.ec2[count.index].instance_id}_${data.aws_instance.ec2[count.index].key_name}" >> project.txt
          echo "security_groups = ${data.aws_instance.ec2[count.index].instance_id}_${join(",",data.aws_instance.ec2[count.index].security_groups)}" >> project.txt
          echo "vpc_security_group_ids =  ${data.aws_instance.ec2[count.index].instance_id}_${join(",",data.aws_instance.ec2[count.index].vpc_security_group_ids)}" >> project.txt
          
          echo " " >> project.txt
      EOT
      interpreter = [ "bash", "-c" ]
    }

################################ Second method ######################################
    #     provisioner "local-exec" {
    #   command = "bash script.sh ${data.aws_instance.ec2.public_ip}  ${data.aws_instance.ec2.private_ip} ${data.aws_instance.ec2.public_dns} ${data.aws_instance.ec2.private_dns} ${data.aws_instance.ec2.key_name} ${join(",",data.aws_instance.ec2.security_groups)} ${join(",",data.aws_instance.ec2.vpc_security_group_ids)}"
         
    # }

}

# resource "aws_instance" "my_server" {
#       ami =  data.aws_instance.ec2.ami
#       instance_type = "t2.small"
#       security_groups = data.aws_instance.ec2.security_groups
#       key_name = data.aws_instance.ec2.key_name
#       user_data = file("flower.sh")

#       tags = {
#         Name = "Data-server"
#       }
     
# }
################################ First method ######################################
# output "name1" {
#   value = data.aws_instance.ec2.public_ip
# }
# output "name2" {
#   value = data.aws_instance.ec2.private_ip
# }
# output "name3" {
#   value = data.aws_instance.ec2.public_dns
# }
# output "name4" {
#   value = data.aws_instance.ec2.private_dns
# }
# output "name5" {
#   value = data.aws_instance.ec2.key_name
# }
# output "security_groups_name" {
#   value = data.aws_instance.ec2.security_groups # [gfgdf,fgfdgdfg,shgfhfghf]
# }
# output "security_group_id" {
#   value = data.aws_instance.ec2.vpc_security_group_ids
# }
# join(",",[gfgdf,fgfdgdfg,shgfhfghf]) ="gfgdf fgfdgdfg shgfhfghf"
# join(",",["sg-0d92bd4751575c88d",]) ="sg-0d92bd4751575c88d"