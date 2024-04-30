resource "aws_vpc" "my-aws-vpc" {

  cidr_block = var.vpc_cidr_bloks
  enable_dns_hostnames = true
  enable_dns_support = true


  tags = {
    Name : "My-Devops-Train"
    env : "Devops-Train-vpc"

  }

}

// create internet gateway here
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my-aws-vpc.id
  tags = {
    Name : "DevOps-IGW"
  }
}

// public route table
resource "aws_route_table" "public_route_table" {
   vpc_id = aws_vpc.my-aws-vpc.id
   route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
   }
}

// associate my publics subnets to principal route table
resource "aws_route_table_association" "ass_sb_pub_az1" {
    count = length(var.public_subnet_blocks)
    subnet_id = aws_subnet.public_subnets_az[count.index].id
    route_table_id = aws_route_table.public_route_table.id
    
}


############################# FOR AZ1 AZ2 ...... AZn #################################################

resource "aws_eip" "eip" {
  count = length(var.public_subnet_blocks)
  depends_on = [ aws_internet_gateway.my_igw ]
  vpc = true
}

//  Public subnets
resource "aws_subnet" "public_subnets_az" {
    
  count = length(var.public_subnet_blocks) 
  cidr_block              = var.public_subnet_blocks[count.index] 
  availability_zone       = var.availability_zone[count.index]    
  vpc_id                  = aws_vpc.my-aws-vpc.id                
  map_public_ip_on_launch = true                                  
}


// Private subnets
resource "aws_subnet" "private_subnets_az" {
  count = length(var.private_subnet_blocks)
  cidr_block        = var.private_subnet_blocks[count.index] 
  availability_zone = var.availability_zone[count.index]     
  vpc_id            = aws_vpc.my-aws-vpc.id                 

}

// Public nat Gateway
resource "aws_nat_gateway" "nat_gateway_pub_az" {

  count = length(var.public_subnet_blocks)

  subnet_id = aws_subnet.public_subnets_az[count.index].id

  allocation_id = aws_eip.eip[count.index].id

  depends_on = [ aws_internet_gateway.my_igw ]

}


// private route table
resource "aws_route_table" "route_table_az" {
  count = length(var.public_subnet_blocks)
   vpc_id = aws_vpc.my-aws-vpc.id
   route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gateway_pub_az[count.index].id
   }
}

// associate my private subnet to route table
resource "aws_route_table_association" "priv_rt_az" {
  count = length(var.private_subnet_blocks)
    subnet_id = aws_subnet.private_subnets_az[count.index].id
    route_table_id = aws_route_table.route_table_az[count.index].id
    
}


