resource "aws_eip" "nat_gateway_eip_1" {
  tags = {
    Name = "RSSchoolDevopsNATGatewayEIP-1"
  }
}

resource "aws_eip" "nat_gateway_eip_2" {
  tags = {
    Name = "RSSchoolDevopsNATGatewayEIP-2"
  }
}

resource "aws_nat_gateway" "nat_gateway_1" {
  allocation_id = aws_eip.nat_gateway_eip_1.id
  subnet_id     = aws_subnet.public_subnet_1.id

  depends_on = [aws_internet_gateway.rsschool_devops_igw]

  tags = {
    Name = "RSSchoolDevopsNATGateway-1"
  }
}

resource "aws_nat_gateway" "nat_gateway_2" {
  allocation_id = aws_eip.nat_gateway_eip_2.id
  subnet_id     = aws_subnet.public_subnet_2.id

  depends_on = [aws_internet_gateway.rsschool_devops_igw]

  tags = {
    Name = "RSSchoolDevopsNATGateway-2"
  }
}
