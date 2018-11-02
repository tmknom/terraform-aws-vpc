# https://www.terraform.io/docs/providers/aws/r/vpc.html
resource "aws_vpc" "default" {
  cidr_block = "${var.cidr_block}"

  instance_tenancy     = "${var.instance_tenancy}"
  enable_dns_support   = "${var.enable_dns_support}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
}
