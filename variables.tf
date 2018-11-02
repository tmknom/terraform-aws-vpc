variable "cidr_block" {
  type        = "string"
  description = "The CIDR block for the VPC."
}

variable "name" {
  type        = "string"
  description = "The name for the VPC."
}

variable "instance_tenancy" {
  default     = "default"
  type        = "string"
  description = "A tenancy option for instances launched into the VPC."
}

variable "enable_dns_support" {
  default     = true
  type        = "string"
  description = "A boolean flag to enable/disable DNS support in the VPC."
}

variable "enable_dns_hostnames" {
  default     = true
  type        = "string"
  description = "A boolean flag to enable/disable DNS hostnames in the VPC."
}

variable "tags" {
  default     = {}
  type        = "map"
  description = "A mapping of tags to assign to all resources."
}
