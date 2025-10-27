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
    cidr_blocks       = ["202.181.130.200/32"]
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


data "aws_ami" "ami_filter" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }


}
resource "aws_instance" "vulnerable_instance" {
  ami                    = data.aws_ami.ami_filter.id 
  instance_type          = "t3.micro"
  subnet_id              = data.aws_subnet.public_a.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  associate_public_ip_address = true
  user_data = file("./vulnscript.sh")
  iam_instance_profile        = "pcs-role-cortex-integrations"

  tags = {
    Name  = "vulnerable-linux-instance-${var.owner}"
    Owner = var.owner
  }
}
