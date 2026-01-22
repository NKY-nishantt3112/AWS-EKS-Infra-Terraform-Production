resource "aws_vpc" "eks_vpc" {
    cidr_block = var.cidr_block
    enable_dns_hostnames = var.enable_dns_hostnames
    enable_dns_support = var.enable_dns_support

    tags = merge(
        var.common_tags,
        { Name = "${var.client_name}_EKS_VPC"}
    )
    
}

resource "aws_internet_gateway" "eks_vpc_igw" {
    vpc_id = aws_vpc.eks_vpc.id

    tags = merge(
        var.common_tags,
        {Name="${var.client_name}_EKS_VPC_IGW"}
    )
    depends_on = [ aws_vpc.eks_vpc ]
}

resource "aws_subnet" "eks_vpc_public_subnet" {
    count = length(var.public_subnet)
    availability_zone = var.azs[count.index]
    cidr_block = var.public_subnet[count.index].cidr_block
    map_public_ip_on_launch = true
    vpc_id = aws_vpc.eks_vpc.id

    tags = merge(
        {Name= "${var.client_name}_EKS_Public_Subnet_${count.index + 1}"},
        var.common_tags
    )
  
}

resource "aws_subnet" "eks_vpc_private_subnet" {
    count = length(var.private_subnet)
    availability_zone = var.azs[count.index]
    cidr_block = var.private_subnet[count.index].cidr_block
    map_public_ip_on_launch = false
    vpc_id = aws_vpc.eks_vpc.id

    tags = merge(
        {Name = "${var.client_name}_EKS_Private_Subnet_${count.index + 1}"},
        var.common_tags
    ) 
}


resource "aws_eip" "eks_vpc_eip" {
    domain = "vpc"
    tags = merge(
        var.common_tags,
        {Name = "${var.client_name}_EKS_VPC_EIP"}
    )
  
}
resource "aws_nat_gateway" "eks_vpc_nat" {
    allocation_id = aws_eip.eks_vpc_eip.id
    subnet_id = aws_subnet.eks_vpc_public_subnet[0].id
    tags = merge(
        var.common_tags,
        {Name = "${var.client_name}_EKS_VPC_NATGW"}
    )
    depends_on = [ aws_vpc.eks_vpc,aws_eip.eks_vpc_eip ]
}

resource "aws_route_table" "eks_vpc_public_route_table" {
    vpc_id = aws_vpc.eks_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.eks_vpc_igw.id
    }
    tags = merge(
        var.common_tags,
        {Name = "${var.client_name}_EKS_VPC_Public_Route_Table"}
    )
}

resource "aws_route_table_association" "eks_vpc_public_routes_association" {
    count = length(var.public_subnet)
    subnet_id = aws_subnet.eks_vpc_public_subnet[count.index].id
    route_table_id = aws_route_table.eks_vpc_public_route_table.id
}

resource "aws_route_table" "eks_vpc_private_route_table" {
    vpc_id = aws_vpc.eks_vpc.id

    route {
        nat_gateway_id = aws_nat_gateway.eks_vpc_nat.id
        cidr_block = "0.0.0.0/0"
    }
    tags = merge(
        var.common_tags,
        {Name ="${var.client_name}_EKS_VPC_Private_Route_Table"}
    )
}


resource "aws_route_table_association" "eks_vpc_private_routes_association" {
    count = length(var.private_subnet)
    subnet_id = aws_subnet.eks_vpc_private_subnet[count.index].id
    route_table_id = aws_route_table.eks_vpc_private_route_table.id
}


resource "aws_security_group" "eks_vpc_security_group" {
    vpc_id = aws_vpc.eks_vpc.id 

    tags = merge(
        var.common_tags,
        {Name = "${var.client_name}_EKS_VPC_Security_Group"}
    )
     
    dynamic "ingress" {
        for_each = var.aws_vpc_security_group
        content {     
          from_port = ingress.value.from_port
          to_port = ingress.value.to_port
          protocol = ingress.value.protocol
          cidr_blocks = ingress.value.cidr_blocks
        }
    }
    }

resource "aws_vpc_security_group_egress_rule" "aws_eks_vpc_sg_egress_rule" {
    security_group_id = aws_security_group.eks_vpc_security_group.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 0
    to_port = 0
    ip_protocol = "-1"
} 


# so this means a bastion host will be attached with a separate sg other than the sg for controlplane and nodegroup for the eks cluster
# so what we actually require in the sg for bastion host
# port 22 from a specific ip range or vpn
# 


#   indexing and ordering like az ap-1a and ap-1b ye order hain to index to change nahi hoga but order change ho skta hai or agar order change hua to terraform use as a change consider karega to teraform introduces a concept which is 

# locals if they are common then define them in root module not in the child module and if some resource specific tags are required to be deinfed then define them in the resource block in the child module and merge them with the tags variable 

