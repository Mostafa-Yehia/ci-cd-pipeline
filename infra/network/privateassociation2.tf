resource "aws_route_table_association" "private_route_association_two" {
  subnet_id      = aws_subnet.private_subnet_two.id
  route_table_id = aws_route_table.private_route_one.id
} 