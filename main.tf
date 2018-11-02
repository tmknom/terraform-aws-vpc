# https://www.terraform.io/docs/providers/aws/r/vpc.html
resource "aws_vpc" "default" {
  cidr_block = "${var.cidr_block}"

  instance_tenancy     = "${var.instance_tenancy}"
  enable_dns_support   = "${var.enable_dns_support}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"

  tags = "${merge(map("Name", var.name), var.tags)}"
}

# https://www.terraform.io/docs/providers/aws/r/internet_gateway.html
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"

  tags = "${merge(map("Name", var.name), var.tags)}"
}
