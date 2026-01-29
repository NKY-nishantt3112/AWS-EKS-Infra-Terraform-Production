variable "common_tags" {
  type = map(string)
}
variable "public_subnet" {
  type = list(object({
    cidr_block = string
  }))
}
variable "private_subnet" {
  type = list(object({
    cidr_block = string
  }))
}
variable "cidr_block" {}

variable "aws_vpc_security_group" {
  description = "Security Group Ingress Rules"
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "client_name" {}

# variable "azs" {
#   type        = list(string)
#   description = "fetched list of az from data module"
# }
# variable "instance_type" {
#   type = string
# }
variable "aws_region" {}
# variable "region_alias_value" {}