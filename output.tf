output "EC2_Public_IP" {
  value = aws_instance.BabyGaffPRIV.public_ip
}
