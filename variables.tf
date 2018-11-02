variable "cidr_block" {
  type        = "string"
  description = "The CIDR block for the VPC."
}

variable "instance_tenancy" {
  default     = "default"
  type        = "string"
  description = "A tenancy option for instances launched into the VPC."
}
