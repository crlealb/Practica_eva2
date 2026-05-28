output "instance_id" {
  value = aws_instance.servidor_web.id
}

output "public_ip" {
  value = aws_instance.servidor_web.public_ip
}
