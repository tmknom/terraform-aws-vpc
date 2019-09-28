# Terraform module which creates VPC resources on AWS.
#
# https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html

# https://www.terraform.io/docs/providers/aws/r/vpc.html
resource "aws_vpc" "default" {
  cidr_block = var.cidr_block

  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                 = merge({ "Name" = var.name }, var.tags)
}

# https://www.terraform.io/docs/providers/aws/r/internet_gateway.html
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags   = merge({ "Name" = var.name }, var.tags)
}

#
# Public network
#

# https://www.terraform.io/docs/providers/aws/r/subnet.html
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.default.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       = var.public_availability_zones[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags                    = merge({ "Name" = format("%s-public-%d", var.name, count.index) }, var.tags)
}

# https://www.terraform.io/docs/providers/aws/r/route_table.html
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id
  tags   = merge({ "Name" = format("%s-public", var.name) }, var.tags)
}

# https://www.terraform.io/docs/providers/aws/r/route.html
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.default.id
  destination_cidr_block = "0.0.0.0/0"
}

# https://www.terraform.io/docs/providers/aws/r/route_table_association.html
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr_blocks)

  subnet_id      = aws_subnet.public.*.id[count.index]
  route_table_id = aws_route_table.public.id
}

# https://www.terraform.io/docs/providers/aws/r/network_acl.html
resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.default.id
  subnet_ids = aws_subnet.public.*.id
  tags       = merge({ "Name" = format("%s-public", var.name) }, var.tags)
}

# https://www.terraform.io/docs/providers/aws/r/network_acl_rule.html
resource "aws_network_acl_rule" "public_ingress" {
  network_acl_id = aws_network_acl.public.id
  egress         = false
  from_port      = 0
  to_port        = 0
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "-1"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "public_egress" {
  network_acl_id = aws_network_acl.public.id
  egress         = true
  from_port      = 0
  to_port        = 0
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "-1"
  cidr_block     = "0.0.0.0/0"
}

#
# Private network
#

# https://www.terraform.io/docs/providers/aws/r/subnet.html
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.default.id
  cidr_block              = var.private_subnet_cidr_blocks[count.index]
  availability_zone       = var.private_availability_zones[count.index]
  map_public_ip_on_launch = false
  tags                    = merge({ "Name" = format("%s-private-%d", var.name, count.index) }, var.tags)
}

# Note: Do not use network_interface to associate the EIP to aws_lb or aws_nat_gateway resources.
#       Instead use the allocation_id available in those resources to allow AWS to manage the association,
#       otherwise you will see AuthFailure errors.
#
# https://www.terraform.io/docs/providers/aws/r/eip.html
resource "aws_eip" "nat_gateway" {
  count = local.nat_gateway_count

  vpc  = true
  tags = merge({ "Name" = format("%s-nat-%d", var.name, count.index) }, var.tags)

  # Note: EIP may require IGW to exist prior to association. Use depends_on to set an explicit dependency on the IGW.
  depends_on = [aws_internet_gateway.default]
}

# https://www.terraform.io/docs/providers/aws/r/nat_gateway.html
resource "aws_nat_gateway" "default" {
  count = local.nat_gateway_count

  allocation_id = aws_eip.nat_gateway.*.id[count.index]
  subnet_id     = aws_subnet.public.*.id[count.index]
  tags          = merge({ "Name" = format("%s-%d", var.name, count.index) }, var.tags)

  # Note: It's recommended to denote that the NAT Gateway depends on the Internet Gateway
  #       for the VPC in which the NAT Gateway's subnet is located.
  depends_on = [aws_internet_gateway.default]
}

# https://www.terraform.io/docs/providers/aws/r/route_table.html
resource "aws_route_table" "private" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id = aws_vpc.default.id
  tags   = merge({ "Name" = format("%s-private-%d", var.name, count.index) }, var.tags)
}

# https://www.terraform.io/docs/providers/aws/r/route.html
resource "aws_route" "private" {
  count = var.enabled_nat_gateway ? length(var.private_subnet_cidr_blocks) : 0

  route_table_id         = aws_route_table.private.*.id[count.index]
  nat_gateway_id         = var.enabled_single_nat_gateway ? aws_nat_gateway.default.*.id[0] : aws_nat_gateway.default.*.id[count.index]
  destination_cidr_block = "0.0.0.0/0"
}

# https://www.terraform.io/docs/providers/aws/r/route_table_association.html
resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr_blocks)

  subnet_id      = aws_subnet.private.*.id[count.index]
  route_table_id = aws_route_table.private.*.id[count.index]
}

# https://www.terraform.io/docs/providers/aws/r/network_acl.html
resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.default.id
  subnet_ids = aws_subnet.private.*.id
  tags       = merge({ "Name" = format("%s-private", var.name) }, var.tags)
}

# https://www.terraform.io/docs/providers/aws/r/network_acl_rule.html
resource "aws_network_acl_rule" "private_ingress" {
  network_acl_id = aws_network_acl.private.id
  egress         = false
  from_port      = 0
  to_port        = 0
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "-1"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "private_egress" {
  network_acl_id = aws_network_acl.private.id
  egress         = true
  from_port      = 0
  to_port        = 0
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "-1"
  cidr_block     = "0.0.0.0/0"
}

locals {
  nat_gateway_count = var.enabled_nat_gateway ? var.enabled_single_nat_gateway ? 1 : length(var.private_subnet_cidr_blocks) : 0
}
