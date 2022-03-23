resource "aws_security_group" "alb-sg" {
  name   = "my-alb-sg"
  vpc_id = "vpc-0ce85cf4afc3b65fe"

  ingress  {
    from_port=80
    to_port=80
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
  }

  egress  {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "ALB-SG"
  }
}