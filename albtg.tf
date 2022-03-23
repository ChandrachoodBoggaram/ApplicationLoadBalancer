resource "aws_lb_target_group" "TG-002" {
  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2 
  }

  name        = "TG-002"
  port        = 80
  protocol    = "HTTP"
  vpc_id = "vpc-0ce85cf4afc3b65fe"
  target_type = "instance"
}

resource "aws_lb_target_group_attachment" "my-tg-attachment1" {
  target_group_arn = aws_lb_target_group.TG-002.arn
  target_id = aws_instance.EC2-1.id
  port             = 80
}