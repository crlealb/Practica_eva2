variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "networking_source" {
  type    = string
  default = "./modules/networking"
}

variable "compute_source" {
  type    = string
  default = "./modules/compute"
}

variable "storage_source" {
  type    = string
  default = "./modules/storage"
}

variable "vpc_name" {
  type    = string
  default = "red-empresa"
}

variable "bucket_prefix" {
  type    = string
  default = "app-bucket"
}

variable "bucket_name" {
  type    = string
  default = "bucket-aplicacion"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ami" {
  type    = string
  default = "ami-0c02fb55956c7d316"
}

variable "instance_name" {
  type    = string
  default = "servidor-web"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "desarrollo"
    Owner       = "equipo-infra"
  }
}
