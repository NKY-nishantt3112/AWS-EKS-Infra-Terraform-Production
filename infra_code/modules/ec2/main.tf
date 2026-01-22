

resource "aws_instance" "bootstrap" {
    ami = data.aws_ami.ubuntu.id
    subnet_id = var.public_subnet_id[0]
    associate_public_ip_address = true
    instance_type = var.instance_type
    key_name = "root-prod-nvirginia-0948"
    iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
    vpc_security_group_ids = [aws_security_group.bastion_host_sg.id]
    user_data =  file("${path.module}/bootstrap.sh")
   
    root_block_device {
      volume_size = "25"
      volume_type = "gp2"
    }
    tags = merge(
        var.common_tags,
        {Name = "${var.client_name}_Bastion_Host"}
    )
}
resource "aws_security_group" "bastion_host_sg" {
    vpc_id = var.vpc_id 
    name = "${var.client_name}_Bastion_Host_SG"

    tags = merge(
        var.common_tags,
        {Name = "${var.client_name}_Bastion_SG"}
    )
}

resource "aws_security_group_rule" "allow_tcp_to_bastion_host" {
    description = "allow inbound tcp on port 22 for ssh"
    type = "ingress"
    cidr_blocks = [var.vpc_cidr_block]
    from_port = 22
    to_port = 22
    security_group_id = aws_security_group.bastion_host_sg.id
    protocol = "tcp"
    
}
