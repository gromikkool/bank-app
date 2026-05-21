terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.36.0"
    }
  }
}

resource "aws_vpc" "bank-app-terr-vpc" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "bank-igw" {
  vpc_id = aws_vpc.bank-app-terr-vpc.id
  tags = {
    Name = "${var.env}-igw"
  }
}

resource "aws_subnet" "bank-public" {
  count = length(var.azs)
  vpc_id = aws_vpc.bank-app-terr-vpc.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = { Name = "${var.env}-public-${var.azs[count.index]}" }
}

resource "aws_subnet" "bank-private" {
  count = length(var.azs)
  vpc_id = aws_vpc.bank-app-terr-vpc.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = { Name = "${var.env}-private-${var.azs[count.index]}" }
}

resource "aws_subnet" "bank-db" {
  count = length(var.azs)
  vpc_id = aws_vpc.bank-app-terr-vpc.id
  cidr_block = var.db_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = { Name = "${var.env}-db-${var.azs[count.index]}" }
}

resource "aws_route_table" "bank-rt-public" {
  vpc_id = aws_vpc.bank-app-terr-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bank-igw.id
  }
  tags = { Name = "${var.env}-rt"}
}

resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.bank-rt-public
  subnet_id = aws_subnet.bank-public
  count = length(aws_subnet.bank-public)
}

