

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.27.0"
    }
  }
}



provider "aws" {
  region = var.aws_region
}
# provider "aws" {
#     alias = var.region_alias
#     region = var.region_alias_value

# }
