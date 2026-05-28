variable "ami" {
  type    = string
  default = "ami-0c02fb55956c7d316"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "instance_name" {
  type    = string
  default = "servidor-web"
}

variable "user_data" {
  type    = string
  default = ""
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "desarrollo"
    Owner       = "equipo-infra"
  }
}
