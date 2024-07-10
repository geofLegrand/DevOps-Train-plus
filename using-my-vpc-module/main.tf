module "my_vpc_module" {
    source  = "app.terraform.io/KeDigit/vpc-module/cloud"
  version = "1.0.0"

  vpc_cidr             = "172.120.0.0/16"
  internet_gw          = true
  enable_dns_hostnames = true
  enable_dns_support   = true
  nbr_azs              = 2
  nbr_prv_sub_blocks   = 4
  nbr_pub_sub_blocks   = 2

  tag_environment      = "dev"
  tag_vpc_name         = "dev-vpc"
  type_nat_gateway     = "1 in AZ"
  region               = "us-east-1"


}
# module "three_tier_vpc" {
#   source = "github.com/geofLegrand/vpc_module"

#   vpc_cidr             = "172.120.0.0/16"
#   internet_gw          = true
#   enable_dns_hostnames = true
#   enable_dns_support   = true
#   nbr_azs              = 2  /* 2 ok 1 ok 2 ok 2 ok 2 ok 1 ok 1 ok 1 ok 2 ok*/
#   nbr_prv_sub_blocks   = 4 /*  4 ok 1 ok 1 ok 1 ok 2 ok 2 ok 2 ok 1 ok 2 ok*/
#   nbr_pub_sub_blocks   = 2 /*  2 ok 2 ok 2 ok 1 ok 1 ok 1 ok 2 ok 1 ok 2 ok*/
#   tag_environment      = "dev"
#   tag_vpc_name         = "dev-vpc"
#   type_nat_gateway     = "1 in AZ"
#   region               = "us-east-1"

# }

output "vpc_id" {
   value = module.my_vpc_module.vpc_id
}

output "priv_subnets_az1" {
  value = module.my_vpc_module.priv_subnets_az1
}
output "priv_subnets_az2" {
  value = module.my_vpc_module.priv_subnets_az2
}
output "pub_subnets" {
  value = module.my_vpc_module.pub_subnets
}
