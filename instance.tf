#Create ec2
resource "aws_instance" "BabyGaffServer" {
  ami           = "DUMMY_VALUE_AMI_ID"
  subnet_id     = "BabyGaffPublic1a"
  instance_type = "t3.micro"
  vpc_security_group_ids = BabyGaffSG
  root_block_device = {
    volume_type = "gp2"
    volume_size = 40
  
  tags = {
    Name = "BabyGaff Web Server"
  }
}

#Create key pair
resource "tls_private_key" "BabyGaffKP" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "BabyGaffKP" {
  key_name   = "BabyGaffKP"
  public_key = tls_private_key.BabyGaffKP.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.BabyGaffKP.private_key_pem}' > ./Downloads/BabyGaffKP.pem"
  }
}
