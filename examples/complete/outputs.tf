output "vpc_arn" {
  value = "${module.vpc.vpc_arn}"
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "vpc_cidr_block" {
  value = "${module.vpc.vpc_cidr_block}"
}

output "vpc_instance_tenancy" {
  value = "${module.vpc.vpc_instance_tenancy}"
}

output "vpc_enable_dns_support" {
  value = "${module.vpc.vpc_enable_dns_support}"
}

output "vpc_enable_dns_hostnames" {
  value = "${module.vpc.vpc_enable_dns_hostnames}"
}

output "vpc_main_route_table_id" {
  value = "${module.vpc.vpc_main_route_table_id}"
}

output "vpc_default_network_acl_id" {
  value = "${module.vpc.vpc_default_network_acl_id}"
}

output "vpc_default_security_group_id" {
  value = "${module.vpc.vpc_default_security_group_id}"
}

output "vpc_default_route_table_id" {
  value = "${module.vpc.vpc_default_route_table_id}"
}

output "internet_gateway_id" {
  value = "${module.vpc.internet_gateway_id}"
}

output "public_subnet_ids" {
  value = "${module.vpc.public_subnet_ids}"
}

output "public_subnet_arns" {
  value = "${module.vpc.public_subnet_arns}"
}

output "public_subnet_cidr_blocks" {
  value = "${module.vpc.public_subnet_cidr_blocks}"
}

output "public_subnet_availability_zones" {
  value = "${module.vpc.public_subnet_availability_zones}"
}

output "public_route_table_id" {
  value = "${module.vpc.public_route_table_id}"
}

output "public_route_table_association_ids" {
  value = "${module.vpc.public_route_table_association_ids}"
}

output "public_network_acl_id" {
  value = "${module.vpc.public_network_acl_id}"
}

output "public_ingress_network_acl_rule_id" {
  value = "${module.vpc.public_ingress_network_acl_rule_id}"
}

output "public_egress_network_acl_rule_id" {
  value = "${module.vpc.public_egress_network_acl_rule_id}"
}

output "private_subnet_ids" {
  value = "${module.vpc.private_subnet_ids}"
}

output "private_subnet_arns" {
  value = "${module.vpc.private_subnet_arns}"
}

output "private_subnet_cidr_blocks" {
  value = "${module.vpc.private_subnet_cidr_blocks}"
}

output "private_subnet_availability_zones" {
  value = "${module.vpc.private_subnet_availability_zones}"
}

output "eip_nat_gateway_ids" {
  value = "${module.vpc.eip_nat_gateway_ids}"
}

output "eip_nat_gateway_private_ips" {
  value = "${module.vpc.eip_nat_gateway_private_ips}"
}

output "eip_nat_gateway_public_ips" {
  value = "${module.vpc.eip_nat_gateway_public_ips}"
}

output "nat_gateway_ids" {
  value = "${module.vpc.nat_gateway_ids}"
}

output "nat_gateway_allocation_ids" {
  value = "${module.vpc.nat_gateway_allocation_ids}"
}

output "nat_gateway_subnet_ids" {
  value = "${module.vpc.nat_gateway_subnet_ids}"
}

output "nat_gateway_network_interface_ids" {
  value = "${module.vpc.nat_gateway_network_interface_ids}"
}

output "nat_gateway_private_ips" {
  value = "${module.vpc.nat_gateway_private_ips}"
}

output "nat_gateway_public_ips" {
  value = "${module.vpc.nat_gateway_public_ips}"
}

output "private_route_table_ids" {
  value = "${module.vpc.private_route_table_ids}"
}

output "private_route_table_association_ids" {
  value = "${module.vpc.private_route_table_association_ids}"
}

output "private_network_acl_id" {
  value = "${module.vpc.private_network_acl_id}"
}

output "private_ingress_network_acl_rule_id" {
  value = "${module.vpc.private_ingress_network_acl_rule_id}"
}

output "private_egress_network_acl_rule_id" {
  value = "${module.vpc.private_egress_network_acl_rule_id}"
}
