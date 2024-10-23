resource "aws_security_group" "sgec2" {
  vpc_id = var.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }
  ingress {
    description = "TCP/80 from All"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TCP/22 from All"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "instance01" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  subnet_id              = var.subnet1a_id
  vpc_security_group_ids = [aws_security_group.sgec2.id]
  user_data              = var.user_data
}

resource "aws_instance" "instance02" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  subnet_id              = var.subnet1a_id
  vpc_security_group_ids = [aws_security_group.sgec2.id]
  user_data              = var.user_data
}

resource "aws_instance" "instance03" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  subnet_id              = var.subnet1c_id
  vpc_security_group_ids = [aws_security_group.sgec2.id]
  user_data              = var.user_data
}

resource "aws_instance" "instance04" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  subnet_id              = var.subnet1c_id
  vpc_security_group_ids = [aws_security_group.sgec2.id]
  user_data              = var.user_data
}

resource "aws_elb" "elb" {
  name            = var.elb_name
  security_groups = [var.elb_security_group_id]
  subnets         = [var.subnet1a_id, var.subnet1c_id]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
  instances = [
    aws_instance.instance01.id, 
    aws_instance.instance02.id,
    aws_instance.instance03.id,
    aws_instance.instance04.id
  ]
}

output "elb_dns_name" {
  value = aws_elb.elb.dns_name
}
