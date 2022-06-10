resource "aws_instance" "ec2a" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.my-kp.key_name
  subnet_id              = module.network.public_subnet_one_id
  vpc_security_group_ids = [aws_security_group.security_group_one.id]
  provisioner "local-exec" {
        command = "echo the server ip address is ${self.public_ip}"
  }
  depends_on = [
    module.network.nat1,
    module.network.public_route_association_one
  ]
}