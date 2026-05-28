variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = "red-empresa"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "public_az" {
  type    = string
  default = "us-east-1a"
}

variable "private_az" {
  type    = string
  default = "us-east-1b"
}

variable "security_group_name" {
  type    = string
  default = "grupo-seguridad-aplicacion"
}

variable "security_group_description" {
  type    = string
  default = "Permite SSH y HTTP/HTTPS entrante"
}

variable "ingress_rules" {
  type = list(any)
  default = [
    {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "desarrollo"
    Owner       = "equipo-infra"
  }
}
