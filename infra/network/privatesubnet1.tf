resource "aws_subnet" "private_subnet_one" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.private_subnet_one_cidr
  availability_zone = var.az1
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet_one"
  }
}
