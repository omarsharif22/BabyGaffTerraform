output "EC2_Public_IP" {
  value = aws_instance.Server.public_ip
}
