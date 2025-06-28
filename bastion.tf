resource "aws_security_group" "bastion_sg" {
  name        = "bastion-host-sg"
  description = "Allow SSH from trusted IPs, allow outbound SSH to private subnets"
  vpc_id      = aws_vpc.rsschool_devops_vpc.id

  ingress {
    description = "Allow SSH from trusted source IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    description = "Allow SSH to private application subnets"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.private_subnet_cidrs
  }

  egress {
    description = "Allow all outbound to internet for updates"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RSSchoolDevops-BastionHost-SG"
  }
}

# Data source to get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "bastion_host" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"

  subnet_id                   = aws_subnet.private_subnet_1.id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.bastion_key.key_name

  tags = {
    Name = "RSSchoolDevops-BastionHost"
  }
}

output "bastion_public_ip" {
  description = "The public IP address of the bastion host."
  value       = aws_instance.bastion_host.public_ip
}
