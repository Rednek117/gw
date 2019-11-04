resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "gw"
  }
}

resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
  tags = {
    Name = "gw"
  }
}

resource "aws_subnet" "PublicSubnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = "${aws_vpc.vpc.id}"

  tags = {
    Name = "PubSub"
  }
}

resource "aws_route_table_association" "arta" {
  subnet_id      = "${aws_subnet.PublicSubnet.id}"
  route_table_id = "${aws_route_table.r.id}"
}

resource "aws_security_group" "subnetsecurity" {
  name   = "subnetsecurity"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = -1
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh" {
  name   = "ssh"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
}
