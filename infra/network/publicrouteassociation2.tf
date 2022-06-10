resource "aws_route_table_association" "public_route_association_two" {
  subnet_id      = aws_subnet.public_subnet_two.id
  route_table_id = aws_route_table.public_route_one.id
} 