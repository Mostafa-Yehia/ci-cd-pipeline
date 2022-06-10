resource "aws_subnet" "public_subnet_two" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_two_cidr
  availability_zone = var.az2
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_two"
  }
}
