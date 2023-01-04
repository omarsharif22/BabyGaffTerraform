#Create VPC in eu-west-1
resource "aws_vpc" "BabyGaffVPC" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true
    
    tags = {
      Name = "BabyGaff Terraform VPC"
    }
}

#Create public subnet #1 in eu-west-1a
resource "aws_subnet" "BabyGaffPublic1a" {
    vpc_id            = aws_vpc.BabyGaffVPC.id
    cidr_block        = var.public_subnet_cidr_blocks
    map_public_ip_on_launch = "true"
    availability_zone = "eu-west-1a"

    tags = {
      Name = "BabyGaff Terraform Public Subnet"
    }
} 

#Create private subnet #2 in eu-west-1a
resource "aws_subnet" "BabyGaffPrivate1a" {
    vpc_id            = aws_vpc.BabyGaffVPC.id
    cidr_block        = var.private_subnet_cidr_blocks
    availability_zone = "eu-west-1a"
    
    tags = {
      Name = "BabyGaff Terraform Private Subnet"
    }
}
