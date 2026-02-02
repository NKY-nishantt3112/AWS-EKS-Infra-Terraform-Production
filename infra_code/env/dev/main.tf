locals {
  common_tags = merge(
    var.common_tags,
    { managed_by = "terraform" }
  )
}
module "data_azs" {
  source = "../../modules/data"
}


module "eks_vpc" {
  source = "../../modules/vpc"

  common_tags            = local.common_tags
  public_subnet          = var.public_subnet
  cidr_block             = var.cidr_block
  aws_vpc_security_group = var.aws_vpc_security_group
  client_name            = var.client_name
  private_subnet         = var.private_subnet
  azs                    = module.data_azs.azs
}


# module "bastion_ec2" {
#   source = "../../modules/ec2"

#   common_tags = local.common_tags
#   vpc_id = module.eks_vpc.vpc_id
#   instance_type = var.instance_type
#   public_subnet_id = module.eks_vpc.vpc_public_subnet[0].id
#   client_name = var.client_name
#   vpc_cidr_block = module.eks_vpc.vpc_cidr_block

# }
