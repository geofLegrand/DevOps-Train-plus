

resource "aws_lightsail_instance" "lightsail_instance" {

  name              = var.name
  availability_zone = var.availability_zone //"us-east-1a"
  blueprint_id      = var.blueprint_id //"centos_7_2009_01"
  bundle_id         = var.bundle_id //"micro_1_0"
  key_pair_name     = var.key_pair_name//"keyAWS"

  tags = {
    name = var.tag_name //"my devops"
    # env  = "dev"
  }


}

