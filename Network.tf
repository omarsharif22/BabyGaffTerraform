provider "aws" {
    access_key = ""
    secret_key = ""
    region = "eu-west-1"
}

#Create VPC in eu-west-1
resource "aws_vpc" "BabyGaffVPC" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true
    
    tags = {
      Name = "BabyGaff Terraform VPC"
    }
}

#Create public subnet # 1 in eu-west-1a
resource "aws_subnet" "BabyGaffPublic1a" {
    vpc_id            = "aws_vpc.BabyGaffVPC.id"
    cidr_block        = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-west-1a"

    tags = {
      Name = "BabyGaff Terraform Public Subnet"
    }
} 

#Create private subnet # 2 in eu-west-1a
resource "aws_subnet" "BabyGaffPrivate1a" {
    vpc_id            = "aws_vpc.BabyGaffVPC.id"
    cidr_block        = "10.0.2.0/24"
    availability_zone = "eu-west-1a"
    
    tags = {
      Name = "BabyGaff Terraform Private Subnet"
    }
} 

#Create IGW in eu-west-1
resource "aws_internet_gateway" "BabyGaffIGW" {
    vpc_id = "aws_vpc.BabyGaffVPC.id"

    tags = {
      Name = "BabyGaff Terraform IGW"
    }
}

#Create route table in eu-west-1
resource "aws_route_table" "BabyGaffRT" {
    vpc_id = "aws_vpc.BabyGaffVPC.id"
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "aws_internet_gateway.BabyGaffIGW.id"
    }

    tags = {
      Name = "BabyGaff Terraform RouteTable"
    }
}

#Connect public subnet to route table
resource "aws_route_table_association" "BabyGaffPublic1a"{
    subnet_id = "{aws_subnet.BabyGaffPublic1a.id}"
    route_table_id = "{aws_route_table.BabyGaffRT.id}"
}

#Create SG for allowing TCP/80 & TCP/22
resource "aws_security_group" "BabyGaffSG" {
    vpc_id      = aws_vpc.BabyGaffVPC.id
    description = "Allow TCP/80 & TCP/22"
    
    ingress {
      description = "Allow SSH traffic"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
      description = "allow traffic from internet"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  
    tags = {
      Name = "BabyGaffSG"
    }
}
