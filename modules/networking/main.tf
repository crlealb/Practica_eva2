# Módulo de red: VPC, subredes, gateway de Internet, tabla de rutas y grupo de seguridad.

resource "aws_vpc" "red_principal" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-vpc"
  })
}

resource "aws_subnet" "publica" {
  vpc_id                  = aws_vpc.red_principal.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.public_az
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-subred-publica"
  })
}

resource "aws_subnet" "privada" {
  vpc_id            = aws_vpc.red_principal.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.private_az

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-subred-privada"
  })
}

resource "aws_internet_gateway" "puerta_internet" {
  vpc_id = aws_vpc.red_principal.id

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-puerta-internet"
  })
}

resource "aws_route_table" "ruta_publica" {
  vpc_id = aws_vpc.red_principal.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.puerta_internet.id
  }

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-tabla-rutas-publica"
  })
}

resource "aws_route_table_association" "asociacion_publica" {
  subnet_id      = aws_subnet.publica.id
  route_table_id = aws_route_table.ruta_publica.id
}

resource "aws_security_group" "aplicacion" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = aws_vpc.red_principal.id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = var.security_group_name
  })
}
