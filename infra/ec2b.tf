resource "aws_instance" "ec2b" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.my-kp.key_name
  subnet_id              = module.network.private_subnet_one_id
  vpc_security_group_ids = [aws_security_group.security_group_two.id]
}