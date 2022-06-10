resource "aws_subnet" "public_subnet_one" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_one_cidr
  availability_zone = var.az1
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_one"
  }
}
