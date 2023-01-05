output "EC2_Public_IP" {
  value = aws_instance.PUB-BabyGaffServer.public_ip
}
