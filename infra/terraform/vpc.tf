resource "aws_vpc" "bank_app" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "bankapp-vpc"
  }
}

resource "aws_internet_gateway" "bank_app_gateway" {
  vpc_id = aws_vpc.bank_app.id
  tags = {
    Name = "bank_gateway"
  }
}

resource "aws_subnet" "bank_app_public_subnet" {
  vpc_id = aws_vpc.bank_app.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "bank_app_public"
  }
}

resource "aws_subnet" "bank_app_private_subnet" {
  vpc_id = aws_vpc.bank_app.id
  cidr_block = "10.0.10.0/24"
  map_public_ip_on_launch = false
  availability_zone = "us-east-1a"

  tags = {
    Name = "bank_app_private"
  }
}

resource "aws_route_table" "bank_app_route_table" {
  vpc_id = aws_vpc.bank_app.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bank_app_gateway.id
  }

  tags = {
    Name = "bankapp-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.bank_app_public_subnet.id
  route_table_id = aws_route_table.bank_app_route_table.id
}
