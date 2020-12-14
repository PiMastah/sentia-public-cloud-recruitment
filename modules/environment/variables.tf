variable "env" {
  type = string
  description = "Environment identifier"
}

variable "account_id" {
  type = string
  description = "Account ID of associated account"
}

variable "cidr_block" {
  type = string
  description = "CIDR block for env subnet"
}

variable "private_subnets" {
  default     = ["10.0.64.0/20", "10.0.96.0/20", "10.0.128.0/20"]
}

variable "public_subnets" {
  default     = ["10.0.80.0/20", "10.0.112.0/20", "10.0.144.0/20"]
}

variable "availability_zones" {
  description = "Availability zones used"
  default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}