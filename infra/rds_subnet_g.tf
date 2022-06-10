resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_subnet_group"
  subnet_ids = [module.network.private_subnet_one_id,module.network.private_subnet_two_id]

  tags = {
    Name = "rds_subnet_group"
  }
}