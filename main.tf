provider "aws" {}

resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    tags       = {
        Name = "Terraform VPC"
    }
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "pub_subnet" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = cidrsubnet("10.0.0.0/16", 4, 1)
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }
}

resource "aws_route_table_association" "route_table_association" {
    subnet_id      = aws_subnet.pub_subnet.id
    route_table_id = aws_route_table.public.id
}

resource "aws_organizations_organization" "org" {}

resource "aws_organizations_account" "environment" {
  name  = var.env
  email = "pimastah+sentia-recruitment-${lower(var.env)}@gmail.com"

  parent_id = aws_organizations_organization.org.roots.0.id
}

module "env" {
  source = "./modules/environment"
  
  env = var.env
  account_id = aws_organizations_account.environment.id
  cidr_block = var.cidr_block
# Check https://aws.amazon.com/blogs/networking-and-content-delivery/vpc-sharing-a-new-approach-to-multiple-accounts-and-vpc-management/
# for VPC sharing between accounts in the same org
#  vpc_id = aws_vpc.vpc.id
}
