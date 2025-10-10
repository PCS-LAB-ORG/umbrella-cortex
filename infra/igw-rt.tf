resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.umbrella.id
  tags = {
    owner = var.owner
  }
}

resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.umbrella.id
  tags = {
    Name  = "rt-public"
    owner = var.owner
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table" "rt_compute" {
  vpc_id = aws_vpc.umbrella.id
  tags = {
    Name  = "rt-compute"
    owner = var.owner
  }

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
}

resource "aws_route_table" "rt_database" {
  vpc_id = aws_vpc.umbrella.id
  tags = {
    Name  = "rt-database"
    owner = var.owner
  }

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
}

# Associations subnet to route tables (à adapter selon ta configuration)

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table_association" "compute_a" {
  subnet_id      = aws_subnet.compute_a.id
  route_table_id = aws_route_table.rt_compute.id
}

resource "aws_route_table_association" "compute_b" {
  subnet_id      = aws_subnet.compute_b.id
  route_table_id = aws_route_table.rt_compute.id
}

resource "aws_route_table_association" "database_a" {
  subnet_id      = aws_subnet.database_a.id
  route_table_id = aws_route_table.rt_database.id
}
