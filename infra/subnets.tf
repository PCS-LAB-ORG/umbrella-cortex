resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.umbrella.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
  tags = {
    Name  = "public-a-${var.owner}"
    owner = var.owner
  }
}

resource "aws_subnet" "public_c" {
  vpc_id                  = aws_vpc.umbrella.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = true
  tags = {
    Name  = "public-c-${var.owner}"
    owner = var.owner
  }
}

resource "aws_subnet" "compute_a" {
  vpc_id            = aws_vpc.umbrella.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.region}a"
  tags = {
    Name  = "compute-a-${var.owner}"
    owner = var.owner
  }
}

resource "aws_subnet" "compute_b" {
  vpc_id            = aws_vpc.umbrella.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "${var.region}b"
  tags = {
    Name  = "compute-b-${var.owner}"
    owner = var.owner
  }
}

resource "aws_subnet" "database_a" {
  vpc_id            = aws_vpc.umbrella.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "${var.region}a"
  tags = {
    Name  = "database-a-${var.owner}"
    owner = var.owner
  }
}

resource "aws_subnet" "compute_a2" {
  vpc_id            = aws_vpc.umbrella.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "${var.region}a"
  tags = {
    Name  = "compute-a-2-${var.owner}"
    owner = var.owner
  }
}