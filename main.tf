terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "git::https://github.com/crlealb/Practica_eva2.git//modules/networking?ref=0.1.0"

  vpc_name = var.vpc_name
  tags     = var.tags
}

module "compute" {
  source = "git::https://github.com/crlealb/Practica_eva2.git//modules/compute?ref=0.1.0"

  subnet_id          = module.network.public_subnet_id
  security_group_ids = [module.network.security_group_id]

  ami           = var.ami
  instance_type = var.instance_type
  instance_name = var.instance_name
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl enable httpd
    systemctl start httpd
    echo "<h1>Servidor Web Corporativo</h1>" > /var/www/html/index.html
  EOF

  tags = var.tags
}

module "storage" {
  source = "git::https://github.com/crlealb/Practica_eva2.git//modules/storage?ref=0.1.0"

  bucket_prefix = var.bucket_prefix
  bucket_name   = var.bucket_name
  tags          = var.tags
}

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.network.vpc_id
}

output "ec2_public_ip" {
  description = "IP pública de la instancia EC2"
  value       = module.compute.public_ip
}

output "s3_bucket_name" {
  description = "Nombre del bucket S3 creado"
  value       = module.storage.bucket_name
}
