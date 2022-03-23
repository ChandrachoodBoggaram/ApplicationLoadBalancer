terraform{
    required_version = "~>1.1.0"
    required_providers {
      aws={
          source="hashicorp/aws"
          version="~>3.0"
      }
    }
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_security_group" "SG-1" {
  vpc_id = "<vpc_id>"

  ingress  {
    from_port=22
    to_port=22
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
  }

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
    "Name" = "Test-sg"
    "owner"= "Chabog"
  }
}


resource "aws_instance" "EC2-1" {
  ami="ami-0069d66985b09d219"
  instance_type = "t2.micro"
  key_name = "chandu1"
  subnet_id = "<private subnet id>"
  vpc_security_group_ids = [aws_security_group.SG-1.id]
  user_data = <<-EOF
    #! /bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    sudo service httpd start
    sudo systemctl enable httpd
    echo "<h1>Hi,This is Chandu Boggaram </h1>" > /var/www/html/index.html
  EOF
  tags = {
      "Name"="Ec2-1"
  }
}