variable "public_subnet_id" {
  type = list(string)
}
variable "instance_type" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "client_name" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "common_tags" {
  type = map(string)
}