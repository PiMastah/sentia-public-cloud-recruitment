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
