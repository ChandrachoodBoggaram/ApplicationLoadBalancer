resource "aws_lb" "my-test-lb" {
  name               = "my-test-lb"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  subnets            = ["subnet-08385993be0328eda","subnet-07a2908e451a29834"]
  enable_deletion_protection = false
tags ={
    "Name"="alb"
}
 
}

resource "aws_lb_listener" "lb_listener" {
  default_action {
    target_group_arn = "${aws_lb_target_group.TG-002.id}"
    type             = "forward"
  }

  #certificate_arn   = "arn:aws:acm:us-east-1:689019322137:certificate/9fcdad0a-7350-476c-b7bd-3a530cf03090"
  load_balancer_arn = "${aws_lb.my-test-lb.arn}"
  port              = "80"
  protocol          = "HTTP"
}

#For this alb i have added security group manually from the console, because there was some error popping up here.


