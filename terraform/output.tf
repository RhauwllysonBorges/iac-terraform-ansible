output "pubic_ip" {
  value = aws_instance.windows_server.public_ip 
}