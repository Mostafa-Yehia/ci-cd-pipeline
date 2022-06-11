resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_security_group.security_group_one.id]
}

resource "aws_lb_target_group" "my_alb_target_group" {
  name     = "my-alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.network.vpc_id
}


resource "aws_lb_target_group_attachment" "my_alb_target_group_register" {
  target_group_arn = aws_lb_target_group.my_alb_target_group.arn
  target_id        = aws_instance.ec2b.id
  port             = 80
}


resource "aws_lb_listener" "my_alb_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_alb_target_group.arn
  }
}


resource "aws_security_group" "lb_sg" {
  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = module.network.vpc_id

  ingress {
    description      = "hit from anywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
   egress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  } 
  tags = {
    Name = "lb_security_group"
  }
}
