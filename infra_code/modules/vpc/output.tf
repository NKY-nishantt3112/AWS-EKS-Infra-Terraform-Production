output "vpc_id" {
    value = aws_vpc.eks_vpc.id
  
}

output "vpc_cidr_block" {
     value = aws_vpc.eks_vpc.cidr_block
}
output "vpc_private_subnet" {
    value = aws_subnet.eks_vpc_private_subnet[*].id  
}

output "vpc_public_subnet" {
  value = aws_subnet.eks_vpc_public_subnet[*].id
}