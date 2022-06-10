resource "aws_security_group" "security_group_two" {
  name        = "port 3000 and allow_ssh"
  description = "Allow port 3000 and allow_ssh"
  vpc_id      = module.network.vpc_id

  ingress {
    description      = "allow_ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [module.network.vpc_cidr]
  }
  ingress {
    description      = "port 3000"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = [module.network.vpc_cidr]
  }
  egress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  } 

  tags = {
    Name = "security_group_two"
  }
}