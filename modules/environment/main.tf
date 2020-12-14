provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/OrganizationAccountAccessRole"
  }
  alias = "environment"
}

module "webservice" {
  source = "../web-service"
  providers = {
    aws = aws.environment
  }

  env = var.env
  vpc_id = aws_vpc.vpc.id
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
  availability_zones = var.availability_zones

# Check https://aws.amazon.com/blogs/networking-and-content-delivery/vpc-sharing-a-new-approach-to-multiple-accounts-and-vpc-management/
# for VPC sharing between accounts in the same org
#  vpc_id = aws_vpc.vpc.id
}
