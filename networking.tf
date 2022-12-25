data "aws_availability_zones" "available" {}

resource "aws_vpc" "terraform_vpc" {
  cidr_block           = var.vpc
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "terraform_vpc"
  }
  lifecycle {
    create_before_destroy = true
  }
}
//public subnet
resource "aws_subnet" "terraform_public_subnet" {
  count                   = length(var.pub_subnet_cidr)
  vpc_id                  = aws_vpc.terraform_vpc.id
  cidr_block              = var.pub_subnet_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "terraform-public-subnet"
  }
  lifecycle {
    create_before_destroy = true
  }
}
//private subnet
resource "aws_subnet" "terraform_private_subnet" {
  count                   = length(var.private_subnet_cidr)
  vpc_id                  = aws_vpc.terraform_vpc.id
  cidr_block              = var.private_subnet_cidr[count.index]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "terraform-private-subnet"
  }
  lifecycle {
    create_before_destroy = true
  }
}
//igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "terraform-igw"
  }

}
//public route table
resource "aws_route_table" "terraform_public_route_table" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "terraform-public-route-table"
  }
}