  variable "allocated_storage" {
    
  }
  variable "storage_type" {
    
  }
    variable "engine" {
    
  }

  variable "db_name" {
    
  }
    variable "engine_version" {
    
  }
    variable "instance_class" {
    
  }
    variable "identifier" {
    
  }
    variable "username" {
    
  }
    variable "password" {
    
  }
      variable "vpc_security_group_ids" {
      
    
  }

    variable "db_subnet_group_name" {
    
  }

    variable "skip_final_snapshot" {
     default = true
  }

    variable "apply_immediately" {
    default = true
  }

    variable "backup_retention_period" {
    default = 0
  }

    variable "deletion_protection" {
    default = false
  }


# skip_final_snapshot     = true
  # apply_immediately       = true
  # backup_retention_period = 0
  # deletion_protection     = false

#          = 10
#               = "gp2"
#                     = "mysql"
#             = "5.7"
#             = "db.t2.micro"
#                 = ""
#                   = ""
#                   = ""
#     = ""
#       = ""
#                    = ""
#        = true
#          = true
#    = 0
#        = false