output "vpc_id" {
  value = aws_vpc.red_principal.id
}

output "public_subnet_id" {
  value = aws_subnet.publica.id
}

output "private_subnet_id" {
  value = aws_subnet.privada.id
}

output "security_group_id" {
  value = aws_security_group.aplicacion.id
}
