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