
variable "eks_sg" {
    type = map(object({
      from_port =  number
      to_port = number
      protocol = string
      cidr_blocks = list(string)
    }))
  
}

variable "vpc_id" {
    type = string
  
}

variable "client_name" {
    type = string
}

variable "common_tags" {
    type = map(string)
}