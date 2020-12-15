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

module "ftp" {
  source = "../ftp"
  providers = {
    aws = aws.environment
  }

  env = var.env
  transfer_server_name = "Transfer-FTP-${var.env}"
  transfer_server_user_names = ["jan-peters"]
  transfer_server_ssh_keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCnfqY7HLD5AhUEqgnEJWH9QfOglSS4hnjTGWlymLyIxKSzmB81/NCKPSKoVr/v3SV+R4QCYPfa9W7M7kgJjsnLIfISp7IrkXWYgDZv9BbJQUxw0+5IXWsXftP97qvX+Oh3be/E9ldw6T7JLql6yMKqmvHmEsyaJzbnAMJzG2rhR/VYk5WVMTcKF8iaC2DM/CeUrAJMBt7HuhXEPMgf8+6n4sVNA8VgJ4O7SZ+MBhxDJ4mrTV4MUhglMqHVOMMUOTx5yEf8B2+fs3sTGXIXkxCGnIIjIOu1wpEjzgeX3tG4bnOVQDybS3jV6qZfCtGlGaUuc+MhwFdnEqGNK7s+jouDiRg3lLvXJ8Vy3CaPRYhsvHeskLcR4qe5e/Q7OhaJKSMnkcjsUEpNZ5tcoDQkhQGVTew385lgoq81Y/s7s5XGBs9FttG5XvrvzJY54XQrMLi2S46SgPL7Ka70tEmqF7lr2TI5ZDl1A2Xst9rQPYA/jT93y1KAMbCbDtcJgGMxmL8="]
}
