variable "name" {
   description = "lightsail name"
}
variable "availability_zone" {
   description = "lightsail az"
}
variable "blueprint_id" {
   description = "lightsail blueprint_id"
}
variable "bundle_id" {
   description = "lightsail bundle_id"
}

variable "key_pair_name" {
   description = "lightsail key_pair_name"
}

variable "tag_name" {
   description = "lightsail tag_name"
   default = "dev"
}