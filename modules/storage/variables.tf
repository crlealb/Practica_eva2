variable "bucket_prefix" {
  type    = string
  default = "app-bucket"
}

variable "bucket_name" {
  type    = string
  default = "bucket-aplicacion"
}

variable "suffix_byte_length" {
  type    = number
  default = 4
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "desarrollo"
    Owner       = "equipo-infra"
  }
}
