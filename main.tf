locals {
  project_name = "terraform-tutorial"
  project_owner = "Mozees"
}

data "aws_vpc" "awsome_vpc" {
  id = var.vpc_id
}

data "aws_subnet" "awesome_pub_sub2"{
    id = "subnet-0585a38bbc245f202"
  
}

data "template_file" "user_data" {
  template = file("${abspath(path.module)}/userdata.yaml")
}

data "aws_ami" "east-amazon-linux-2" {
    most_recent = true
    filter {
        name   = "owner-alias"
        values = ["amazon"]
    }
    filter {
        name   = "name"
        values = ["amzn2-ami-hvm*"]
    }
}

resource "aws_security_group" "app_server_sg" {
  name        = "app_server_sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = data.aws_vpc.awsome_vpc.id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.my_ip_with_cidr]
   
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.public_key
}

resource "aws_instance" "app_server" {
  ami                     = "${data.aws_ami.east-amazon-linux-2.id}"
  instance_type           = var.instance_type
  vpc_security_group_ids  = [aws_security_group.app_server_sg.id]
  key_name                = "${aws_key_pair.deployer.key_name}"
  subnet_id               = data.aws_subnet.awesome_pub_sub2.id
  user_data               = data.template_file.user_data.rendered
  tags = {
    Name = var.server_name
    Owner = var.server_owner
  }
}

