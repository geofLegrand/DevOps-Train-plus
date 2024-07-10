resource "random_string" "random" {
   length = 6
   special = false
   upper = false
}



resource "aws_s3_bucket" "my_bucket" {
   provider = aws.acm_provider
  bucket ="static-dev-${random_string.random.result}"

  //force_destroy = yes
}


resource "aws_s3_bucket_public_access_block" "buket_access" {
   provider = aws.acm_provider
   bucket = aws_s3_bucket.my_bucket.id
   restrict_public_buckets = false
   block_public_policy = false
   block_public_acls = false
   ignore_public_acls = false

}

resource "aws_s3_bucket_policy" "bucket_policy" {
   provider = aws.acm_provider
   bucket = aws_s3_bucket.my_bucket.id
  #  lifecycle {
     
  #  }
   policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.my_bucket.arn}/*"  //"arn:aws:s3:::${aws_s3_bucket.my_bucket.id}/*"
        }
    ]
})
}


resource "null_resource" "my_resource" {
   provider = aws.acm_provider
   provisioner "local-exec" {
     command = <<-EOF
        aws s3 cp --recursive web s3://${aws_s3_bucket.my_bucket.bucket}/

     EOF 
   }
   depends_on = [ aws_s3_bucket.my_bucket ]
}


resource "aws_s3_bucket_website_configuration" "config_web" {
   provider = aws.acm_provider
    bucket = aws_s3_bucket.my_bucket.id
   index_document {
     suffix = "index.html"
   }
   error_document {
     key = "index.html"
   }
#    redirect_all_requests_to {
#      protocol = ""
#    }
}


output "web_link" {

    value = "http://${aws_s3_bucket.my_bucket.website_endpoint}" 
  
}


##################### CloudFront copy from registry.terraform #####################

# resource "aws_cloudfront_origin_access_control" "curr_origin" {
#   name = "OAC ${aws_s3_bucket.my_bucket}"

# }
# resource "aws_cloudfront_distribution" "s3_distribution" {
#   origin {
#     domain_name = aws_s3_bucket.my_bucket.bucket_regional_domain_name
#     origin_id   = local.s3_origin_id,
#     origin_access_control_id = 

#     # s3_origin_config {
#     #   origin_access_identity = "origin-access-identity/cloudfront/ABCDEFG1234567"
#     # }
#   }

#   enabled             = true
#   is_ipv6_enabled     = true
#   comment             = "Some comment"
#   default_root_object = "index.html"

#   logging_config {
#     include_cookies = false
#     bucket          = "mylogs.s3.amazonaws.com"
#     prefix          = "myprefix"
#   }

#   aliases = ["mysite.example.com", "yoursite.example.com"]

#   default_cache_behavior {
#     allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = local.s3_origin_id

#     forwarded_values {
#       query_string = false

#       cookies {
#         forward = "none"
#       }
#     }

#     viewer_protocol_policy = "allow-all"
#     min_ttl                = 0
#     default_ttl            = 3600
#     max_ttl                = 86400
#   }

#   # Cache behavior with precedence 0
#   ordered_cache_behavior {
#     path_pattern     = "/content/immutable/*"
#     allowed_methods  = ["GET", "HEAD", "OPTIONS"]
#     cached_methods   = ["GET", "HEAD", "OPTIONS"]
#     target_origin_id = local.s3_origin_id

#     forwarded_values {
#       query_string = false
#       headers      = ["Origin"]

#       cookies {
#         forward = "none"
#       }
#     }

#     min_ttl                = 0
#     default_ttl            = 86400
#     max_ttl                = 31536000
#     compress               = true
#     viewer_protocol_policy = "redirect-to-https"
#   }

#   # Cache behavior with precedence 1
#   ordered_cache_behavior {
#     path_pattern     = "/content/*"
#     allowed_methods  = ["GET", "HEAD", "OPTIONS"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = local.s3_origin_id

#     forwarded_values {
#       query_string = false

#       cookies {
#         forward = "none"
#       }
#     }

#     min_ttl                = 0
#     default_ttl            = 3600
#     max_ttl                = 86400
#     compress               = true
#     viewer_protocol_policy = "redirect-to-https"
#   }

#   price_class = "PriceClass_200"

#   restrictions {
#     geo_restriction {
#       restriction_type = "whitelist"
#       locations        = ["US", "CA", "GB", "DE"]
#     }
#   }

#   tags = {
#     Environment = "production"
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = true
#   }
# }