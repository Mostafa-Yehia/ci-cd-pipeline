resource "aws_security_group" "rds_security_group" {
  name        = "rds_security_group"
  description = "rds_security_group"
  vpc_id      = module.network.vpc_id

  ingress {
    description      = "port 3306"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = [module.network.private_subnet_one.cidr_block,module.network.private_subnet_two.cidr_block]
  }
  depends_on = [
    module.network.private_subnet_one_id,
    module.network.private_subnet_two_id
  ]

  tags = {
    Name = "rds_security_group"
  }
}