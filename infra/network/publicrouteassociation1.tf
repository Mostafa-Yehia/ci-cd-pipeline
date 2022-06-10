resource "aws_route_table_association" "public_route_association_one" {
  subnet_id      = aws_subnet.public_subnet_one.id
  route_table_id = aws_route_table.public_route_one.id
} 