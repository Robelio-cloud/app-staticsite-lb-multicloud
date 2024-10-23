resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = "true"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "subnet1a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet1a_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.az1
}

resource "aws_subnet" "subnet1c" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet1c_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.az2
}

resource "aws_route_table" "route" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "route_association1a" {
  subnet_id      = aws_subnet.subnet1a.id
  route_table_id = aws_route_table.route.id
}

resource "aws_route_table_association" "route_association1c" {
  subnet_id      = aws_subnet.subnet1c.id
  route_table_id = aws_route_table.route.id
}

resource "aws_security_group" "sglb" {
  vpc_id = aws_vpc.vpc.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
