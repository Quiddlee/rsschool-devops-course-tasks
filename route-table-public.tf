resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.rsschool_devops_vpc.id

  tags = {
    Name = "RSSchoolDevopsRouteTable"
  }
}

resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = var.all_ipv4_cidrs
  gateway_id             = aws_internet_gateway.rsschool_devops_igw.id
}

resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}
