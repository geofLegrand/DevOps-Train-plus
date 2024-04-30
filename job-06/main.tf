
module "my_docker" {
  count                = length(var.ec2_docker)
  source               = "../ec2_module/ec2"
  ami                  = "ami-0a699202e5027c10d"
  instance_type        = "t2.micro"
  key_name             = "my-key"
  tags_name            = var.ec2_docker[count.index].serv
  user_data            = file("install_docker.sh")
  iam_instance_profile = aws_iam_instance_profile.myprofile.name

  depends_on = [aws_iam_instance_profile.myprofile]
}

resource "aws_iam_instance_profile" "myprofile" {
  name = "my_profile"
  role = aws_iam_role.myrole.name

}
resource "aws_iam_role" "myrole" {
  name = "myroleAdminRole"
  // service than i apply the role
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    }
  )

  tags = {
    tag-key = "Deploy_app"
  }
}


# // differents policies
# resource "aws_iam_role_policy_attachment" "s3_acces" {
#   role       = aws_iam_role.myrole.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
# }
resource "aws_iam_role_policy_attachment" "admin_access" {
  role       = aws_iam_role.myrole.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


variable "environment" {

  default = [
    # { ripo = "dev/app-1/frontend", tag = "Development",image = "IMMUTABLE"},
    { ripo = "prod/app-1/frontend", tag = "production", image = "MUTABLE" },
    { ripo = "uat/app-1/frontend", tag = "user acceptance testing", image = "IMMUTABLE" }, // user acceptance testing
    { ripo = "qa/app-1/frontend", tag = "Quality Assurance", image = "IMMUTABLE" }
  ]
}

variable "ec2_docker" {

  default = [
    { serv = "dev-serv", tag = "production" },
    { serv = "uat-serv", tag = "user acceptance testing" }, // user acceptance testing
    { serv = "qa-serv", tag = "Quality Assurance" }
  ]
}

#   encryption_configuration {
#     encryption_type = "KMS"
#   }
resource "aws_ecr_repository" "dev" {
  count                = length(var.environment)
  name                 = var.environment[count.index].ripo
  image_tag_mutability = var.environment[count.index].image

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
    Name = var.environment[count.index].tag
  }


}


resource "null_resource" "excute_resource" {
  count = length(var.ec2_docker)
  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = module.my_docker[count.index].public_ip
    private_key = file("../manual_key/my-key.pem") // file.pem
  }

  provisioner "remote-exec" {

    inline = [
      "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin  ${join(",", split("/", aws_ecr_repository.dev[0].repository_url))}",


    ]
    #  389035013580.dkr.ecr.us-east-1.amazonaws.com
  }
  depends_on = [module.my_docker]
}

output "uri" {
  value = aws_ecr_repository.dev[*].repository_url
}

output "uri0" {
  value = join(",", split("/", aws_ecr_repository.dev[0].repository_url))

}