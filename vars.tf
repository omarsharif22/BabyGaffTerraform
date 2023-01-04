variable "AWS_REGION" {
  description = "AWS region in ireland"
  type = string
  default = "eu-west-1"
}

variable "AMIS" {
  description = "Ec2 Launch (AMi must exist)"
  type = map(string)
  default = {
    "eu-west-1" = "Ami-id"
  }
}

variable "INSTANCE_USERNAME" {
  description = "username for remote-exec with launched instance"
  type = string
  default = "BabyGaff"
}

variable "instance_count" {
  description = "number of instances to create"
  type = number
  default = 2
}

variable "public_subnet_count" {
  description = "number of public subnets"
  type = number
  default = 2
}

variable "private_subnet_count" {
  description = "number of private subnets"
  type = number
  default = 2
}

variable "public_subnet_cidr_blocks" {
  description = "available cidr blocks for public subnets"
  type = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr_blocks" {
  description = "available cidr blocks for private subnets"
  type = string
  default = "10.0.10.0/24"
}
