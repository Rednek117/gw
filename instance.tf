data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "Devtools" {
  ami             = "${data.aws_ami.ubuntu.id}"
  instance_type   = "t2.micro"
  key_name        = "aws"
  security_groups = ["${aws_security_group.subnetsecurity.id}", "${aws_security_group.ssh.id}"]
  subnet_id       = "${aws_subnet.PublicSubnet.id}"

  tags = {
    Name = "Devtools"
  }

  user_data = <<EOF
#!/bin/bash
sudo apt update
sudp apt install python -y
EOF
}

resource "aws_instance" "CI" {
  ami             = "${data.aws_ami.ubuntu.id}"
  instance_type   = "t2.micro"
  key_name        = "aws"
  security_groups = ["${aws_security_group.subnetsecurity.id}", "${aws_security_group.ssh.id}"]
  subnet_id       = "${aws_subnet.PublicSubnet.id}"

  tags = {
    Name = "CI"
  }
  user_data = <<EOF
#!/bin/bash
sudo apt update
sudp apt install python -y
EOF
}


resource "aws_instance" "Artifactory" {
  ami             = "${data.aws_ami.ubuntu.id}"
  instance_type   = "t2.micro"
  key_name        = "aws"
  security_groups = ["${aws_security_group.subnetsecurity.id}", "${aws_security_group.ssh.id}"]
  subnet_id       = "${aws_subnet.PublicSubnet.id}"

  tags = {
    Name = "Artifactory"
  }
  user_data = <<EOF
#!/bin/bash
sudo apt update
sudo apt install python -y
EOF
}

resource "aws_instance" "Docker" {
  ami             = "${data.aws_ami.ubuntu.id}"
  instance_type   = "t2.micro"
  key_name        = "aws"
  security_groups = ["${aws_security_group.subnetsecurity.id}", "${aws_security_group.ssh.id}"]
  subnet_id       = "${aws_subnet.PublicSubnet.id}"

  tags = {
    Name = "Docker"
  }
  user_data = <<EOF
#!/bin/bash
sudo apt update
sudo apt install python -y
EOF
}
