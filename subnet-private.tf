resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.rsschool_devops_vpc.id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "RSSchoolDevopsPrivateSubnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.rsschool_devops_vpc.id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "RSSchoolDevopsPrivateSubnet-2"
  }
}
