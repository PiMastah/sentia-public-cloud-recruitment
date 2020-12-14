variable "env" {
  type = string
  description = "Environment identifier"
}

variable "vpc_id" {
  description = "account specific VPC id"
}

variable "private_subnets" {
  default     = ["10.0.0.0/20", "10.0.32.0/20", "10.0.64.0/20"]
}

variable "public_subnets" {
  default     = ["10.0.16.0/20", "10.0.48.0/20", "10.0.80.0/20"]
}

variable "availability_zones" {
  description = "Availability zones used"
  default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}