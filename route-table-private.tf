resource "aws_route_table" "private_rt_1" {
  vpc_id = aws_vpc.rsschool_devops_vpc.id

  tags = {
    Name = "RSSchoolDevopsPrivateRouteTable-1"
  }
}

resource "aws_route" "private_nat_route_1" {
  route_table_id         = aws_route_table.private_rt_1.id
  destination_cidr_block = var.all_ipv4_cidrs
  nat_gateway_id         = aws_nat_gateway.nat_gateway_1.id
}

resource "aws_route_table" "private_rt_2" {
  vpc_id = aws_vpc.rsschool_devops_vpc.id

  tags = {
    Name = "RSSchoolDevopsPrivateRouteTable-2"
  }
}

resource "aws_route" "private_nat_route_2" {
  route_table_id         = aws_route_table.private_rt_2.id
  destination_cidr_block = var.all_ipv4_cidrs
  nat_gateway_id         = aws_nat_gateway.nat_gateway_2.id
}

resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt_1.id
}

resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_rt_2.id
}
