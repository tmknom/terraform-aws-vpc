output "vpc_arn" {
  value       = "${aws_vpc.default.arn}"
  description = "Amazon Resource Name (ARN) of VPC."
}

output "vpc_id" {
  value       = "${aws_vpc.default.id}"
  description = "The ID of the VPC."
}

output "vpc_cidr_block" {
  value       = "${aws_vpc.default.cidr_block}"
  description = "The CIDR block of the VPC."
}

output "vpc_instance_tenancy" {
  value       = "${aws_vpc.default.instance_tenancy}"
  description = "Tenancy of instances spin up within VPC."
}

output "vpc_enable_dns_support" {
  value       = "${aws_vpc.default.enable_dns_support}"
  description = "Whether or not the VPC has DNS support."
}

output "vpc_enable_dns_hostnames" {
  value       = "${aws_vpc.default.enable_dns_hostnames}"
  description = "Whether or not the VPC has DNS hostname support."
}

output "vpc_main_route_table_id" {
  value       = "${aws_vpc.default.main_route_table_id}"
  description = "The ID of the main route table associated with this VPC."
}

output "vpc_default_network_acl_id" {
  value       = "${aws_vpc.default.default_network_acl_id}"
  description = "The ID of the network ACL created by default on VPC creation."
}

output "vpc_default_security_group_id" {
  value       = "${aws_vpc.default.default_security_group_id}"
  description = "The ID of the security group created by default on VPC creation."
}

output "vpc_default_route_table_id" {
  value       = "${aws_vpc.default.default_route_table_id}"
  description = "The ID of the route table created by default on VPC creation."
}

output "internet_gateway_id" {
  value       = "${aws_internet_gateway.default.id}"
  description = "The ID of the Internet Gateway."
}

output "public_subnet_ids" {
  value       = ["${aws_subnet.public.*.id}"]
  description = "The IDs of the public subnets."
}

output "public_subnet_arns" {
  value       = ["${aws_subnet.public.*.arn}"]
  description = "The ARNs of the public subnets."
}

output "public_subnet_cidr_blocks" {
  value       = ["${aws_subnet.public.*.cidr_block}"]
  description = "The CIDR blocks for the public subnets."
}

output "public_subnet_availability_zones" {
  value       = ["${aws_subnet.public.*.availability_zone}"]
  description = "The Availability Zones for the public subnets."
}

output "public_route_table_id" {
  value       = "${aws_route_table.public.id}"
  description = "The ID of the public routing table."
}

output "private_subnet_ids" {
  value       = ["${aws_subnet.private.*.id}"]
  description = "The IDs of the private subnets."
}

output "private_subnet_arns" {
  value       = ["${aws_subnet.private.*.arn}"]
  description = "The ARNs of the private subnets."
}

output "private_subnet_cidr_blocks" {
  value       = ["${aws_subnet.private.*.cidr_block}"]
  description = "The CIDR blocks for the private subnets."
}

output "private_subnet_availability_zones" {
  value       = ["${aws_subnet.private.*.availability_zone}"]
  description = "The Availability Zones for the private subnets."
}
