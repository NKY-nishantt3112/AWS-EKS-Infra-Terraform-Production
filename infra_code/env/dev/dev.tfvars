aws_region = "ap-south-1"

client_name = "nishant"

common_tags = {
  name   = "demo-name"
  owner  = "demo-terraform"
  team   = "devops"
  bu     = "EKS"
  env    = "dev"
}

cidr_block = "100.0.0.0/16"

enable_dns_hostnames = true
enable_dns_support   = true

public_subnet = [
  {
    cidr_block = "100.0.1.0/24"
  },
  {
    cidr_block = "100.0.2.0/24"
  }
]

private_subnet = [
  {
    cidr_block = "100.0.21.0/24"
  },
  {
    cidr_block = "100.0.22.0/24"
  },
  {
    cidr_block = "100.0.23.0/24"
  }
]

aws_vpc_security_group = {
  ssh = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  http = {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  https = {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

