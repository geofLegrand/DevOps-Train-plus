resource "aws_instance" "ec2_instance" {
  ami                                  = var.ami
  associate_public_ip_address          = var.give_public_ip_address
  availability_zone                    = var.availability_zone
#   cpu_core_count                       = 1
#   cpu_threads_per_core                 = 1
#   disable_api_stop                     = false
#   disable_api_termination              = false
#   ebs_optimized                        = false
#   get_password_data                    = false
#   hibernation                          = false
#   host_id                              = null
#   host_resource_group_arn              = null
#   iam_instance_profile                 = null
#   instance_initiated_shutdown_behavior = "stop"
  instance_type                        = var.instance_type
#   ipv6_address_count                   = 0
#   ipv6_addresses                       = []
  key_name                             = var.key_name
#   monitoring                           = false
#   placement_group                      = null
#   placement_partition_number           = 0

#   secondary_private_ips                = []
#   security_groups                      = ["default"]
#   source_dest_check                    = true
  subnet_id                            = var.default_subnet
  tags = {
    Name = var.tags_name
  }
#   tags_all = {
#     Name = "Docker_server"
#   }
#   tenancy                     = "default"
  user_data                   = var.user_data
#   user_data_base64            = null
#   user_data_replace_on_change = null
#   volume_tags                 = null
  vpc_security_group_ids      = [var.default_vpc_sg]
  # capacity_reservation_specification {
  #   capacity_reservation_preference = "open"
  # }
  # credit_specification {
  #   cpu_credits = "standard"
  # }
  # enclave_options {
  #   enabled = false
  # }
  # maintenance_options {
  #   auto_recovery = "default"
  # }
  # metadata_options {
  #   http_endpoint               = "enabled"
  #   http_put_response_hop_limit = 1
  #   http_tokens                 = "optional"
  #   instance_metadata_tags      = "disabled"
  # }
  # private_dns_name_options {
  #   enable_resource_name_dns_a_record    = false
  #   enable_resource_name_dns_aaaa_record = false
  #   hostname_type                        = "ip-name"
  # }
  # root_block_device {
  #   delete_on_termination = true
  #   encrypted             = false
  #   iops                  = 100
  #   kms_key_id            = null
  #   tags                  = {}
  #   throughput            = 0
  #   volume_size           = 8
  #   volume_type           = "gp2"
  # }
}