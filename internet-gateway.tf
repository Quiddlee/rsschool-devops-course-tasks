resource "aws_internet_gateway" "rsschool_devops_igw" {
  vpc_id = aws_vpc.rsschool_devops_vpc.id

  tags = {
    Name = "RSSchoolDevopsIGW"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}
