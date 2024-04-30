

# module "key-name" {
#    source = "./key-pair"
#    ablam_key = "farelle-key"
# }

module "key_name" {
  source = "./key-pair-lightsail"
  key_name = "farelle-key"
}

module "lightserver" {
  source = "../../module/lightsail"
  name = var.main_name
  blueprint_id = var.main_blueprint_id
  availability_zone = var.main_availability_zone
  bundle_id = var.main_bundle_id
  key_pair_name = module.key_name.output_key_name
  
}

