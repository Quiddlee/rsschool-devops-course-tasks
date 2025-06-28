resource "aws_security_group" "k3s_node_sg" {
  name        = "k3s-node-sg"
  description = "Allow K3s cluster communication and SSH from bastion"
  vpc_id      = aws_vpc.rsschool_devops_vpc.id

  ingress {
    description = "Allow SSH from Bastion Host"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  ingress {
    description = "Allow K3s Server API (6443) from self (for agents) and bastion"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    security_groups = ["self", aws_security_group.bastion_sg.id]
  }

  ingress {
    description = "Allow Flannel VXLAN (8472 UDP) from self"
    from_port   = 8472
    to_port     = 8472
    protocol    = "udp"
    security_groups = ["self"]
  }

  ingress {
    description = "Allow Kubelet (10250 TCP) from self"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    security_groups = ["self"]
  }

  ingress {
    description = "Allow NodePort Range (30000-32767) from VPC for internal access"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.rsschool_devops_vpc.cidr_block]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RSSchoolDevops-K3sNode-SG"
  }
}
