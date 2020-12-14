resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    tags       = {
        Name = "Terraform VPC"
    }

    provider = aws.environment
}

resource "aws_subnet" "env-subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.cidr_block

    provider = aws.environment
}
