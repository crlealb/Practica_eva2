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

module "networking" {
  source = var.networking_source

  vpc_name = var.vpc_name
  tags     = var.tags
}

module "compute" {
  source = var.compute_source

  subnet_id          = module.networking.public_subnet_id
  security_group_ids = [module.networking.security_group_id]

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
  source = var.storage_source

  bucket_prefix = var.bucket_prefix
  bucket_name   = var.bucket_name
  tags          = var.tags
}

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.networking.vpc_id
}

output "ec2_public_ip" {
  description = "IP pública de la instancia EC2"
  value       = module.compute.public_ip
}

output "s3_bucket_name" {
  description = "Nombre del bucket S3 creado"
  value       = module.storage.bucket_name
}
