provider "aws" {
  region = var.region
}

# Data source to get the public subnet "public-a" details (assumed already exist in infra)
data "aws_subnet" "public_a" {
  filter {
    name   = "tag:Name"
    values = ["public-a-${var.owner}"]
  }
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["umbrella_vpc-${var.owner}"]
  }
}

# Security group to allow SSH (port 22) from anywhere (instance accessible publiquement)
resource "aws_security_group" "public_sg" {
  name        = "public-ssh-sg"
  description = "Allow SSH inbound"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    description       = "SSH from anywhere"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    ipv6_cidr_blocks  = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Instance using deliberately a vulnerable image (here, an older Amazon Linux 2 AMI)
data "aws_ami" "vulnerable_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.9.20251014.0-kernel-6.12-x86_64"] # Early 2020 version (example vulnerable)
  }
}

resource "aws_instance" "vulnerable_instance" {
  ami                    = data.aws_ami.vulnerable_linux.id
  instance_type          = "t3.micro"
  subnet_id              = data.aws_subnet.public_a.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  associate_public_ip_address = true

  tags = {
    Name  = "vulnerable-linux-instance"
    Owner = var.owner
  }
}