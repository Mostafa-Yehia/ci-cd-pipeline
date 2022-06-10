resource "aws_eip" "eip1" {
  vpc      = true
  tags = {
    Name = "eip1"
  }
}

ip = 45.6.3.7
pool_index = 55