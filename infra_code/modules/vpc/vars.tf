

variable "common_tags" {
  type = map(string)
  description = "common tags for the client's infra"
}

variable "cidr_block" {
  type = string
}

variable "enable_dns_hostnames" {
  type = bool
}
variable "enable_dns_support" {
  type = bool
}
variable "client_name" {
  type = string
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

variable "azs" {
    type = list(string)
    description = "fetched list of az from data module"  
}

variable "aws_vpc_security_group" {
    description = "Security Group Ingress Rules"
    type = map(object({
      from_port = number
      to_port= number
      protocol = string
      cidr_blocks = list(string) 
    }))
}



