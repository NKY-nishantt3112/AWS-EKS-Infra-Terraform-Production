

resource "aws_security_group" "eks_control_plane_sg" {
    description = "EKS cluster control plane security group"
    vpc_id = var.vpc_id
    tags = merge(
        var.common_tags,
        {Name = "${var.client_name}_EKS_Control_Plane_SG"}
    ) 
}
resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = [ aws_security_group.eks_data_plane_sg.id]
  security_group_id = aws_security_group.eks_control_plane_sg.id
}

resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = [ aws_security_group.bastion_host_sg.id]
  security_group_id = aws_security_group.eks_control_plane_sg.id
}


resource "aws_security_group" "eks_data_plane_sg" {
    description = "EKS cluster data plane security group"
    vpc_id = var.vpc_id
    tags = merge(
        var.common_tags,
        {Name = "${var.client_name}_EKS_data_Plane_SG"}
    ) 
}





