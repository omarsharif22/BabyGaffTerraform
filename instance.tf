#Create Key Pair
resource "tls_private_key" "oskey" {
  algorithm = "RSA"
}

resource "local_file" "myterrakey" {
  content  = tls_private_key.oskey.private_key_pem
  filename = "myterrakey.pem"
}

resource "aws_key_pair" "key121" {
  key_name   = "myterrakey"
  public_key = tls_private_key.oskey.public_key_openssh
}

#Create Ec2 public subnet
resource "aws_instance" "BabyGaffPUB" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key121.key_name
  subnet_id     = aws_subnet.BabyGaffPublic1a.id
  vpc_security_group_ids = [aws_security_group.BabyGaffSG.id]
  
  tags = {
    name = "PUB-BabyGaffServer"
  }  
}

#Create Ec2 Private subnet
resource "aws_instance" "BabyGaffPRIV" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key121.key_name
  subnet_id     = aws_subnet.BabyGaffPrivate1a.id
  vpc_security_group_ids = [aws_security_group.BabyGaffSG.id]
  
  tags = {
    name = "PRIV-BabyGaffServer"
  } 
}
