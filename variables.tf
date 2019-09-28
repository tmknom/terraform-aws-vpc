variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC."
}

variable "name" {
  type        = string
  description = "The name for the VPC."
}

variable "instance_tenancy" {
  default     = "default"
  type        = string
  description = "A tenancy option for instances launched into the VPC."
}

variable "enable_dns_support" {
  default     = true
  type        = string
  description = "A boolean flag to enable/disable DNS support in the VPC."
}

variable "enable_dns_hostnames" {
  default     = true
  type        = string
  description = "A boolean flag to enable/disable DNS hostnames in the VPC."
}

variable "public_subnet_cidr_blocks" {
  default     = []
  type        = list(string)
  description = "The CIDR blocks for the public subnets."
}

variable "public_availability_zones" {
  default     = []
  type        = list(string)
  description = "The Availability Zones for the public subnets."
}

variable "map_public_ip_on_launch" {
  default     = true
  type        = string
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address."
}

variable "private_subnet_cidr_blocks" {
  default     = []
  type        = list(string)
  description = "The CIDR blocks for the private subnets."
}

variable "private_availability_zones" {
  default     = []
  type        = list(string)
  description = "The Availability Zones for the private subnets."
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "A mapping of tags to assign to all resources."
}

variable "enabled_nat_gateway" {
  default     = true
  type        = string
  description = "Set to false to prevent the module from creating NAT Gateway resources."
}

variable "enabled_single_nat_gateway" {
  default     = false
  type        = string
  description = "Set to true to create single NAT Gateway resource."
}
