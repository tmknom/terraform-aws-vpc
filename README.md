# terraform-aws-vpc

[![Terraform Actions Status](https://github.com/tmknom/terraform-aws-vpc/workflows/Terraform/badge.svg)](https://github.com/tmknom/terraform-aws-vpc/actions?query=workflow%3ATerraform)
[![Markdown Actions Status](https://github.com/tmknom/terraform-aws-vpc/workflows/Markdown/badge.svg)](https://github.com/tmknom/terraform-aws-vpc/actions?query=workflow%3AMarkdown)
[![YAML Actions Status](https://github.com/tmknom/terraform-aws-vpc/workflows/YAML/badge.svg)](https://github.com/tmknom/terraform-aws-vpc/actions?query=workflow%3AYAML)
[![JSON Actions Status](https://github.com/tmknom/terraform-aws-vpc/workflows/JSON/badge.svg)](https://github.com/tmknom/terraform-aws-vpc/actions?query=workflow%3AJSON)
[![GitHub tag](https://img.shields.io/github/tag/tmknom/terraform-aws-vpc.svg)](https://registry.terraform.io/modules/tmknom/vpc/aws)
[![License](https://img.shields.io/github/license/tmknom/terraform-aws-vpc.svg)](https://opensource.org/licenses/Apache-2.0)

Terraform module which creates VPC resources on AWS.

## Description

Provision [VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html),
[Subnets](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html),
[Route Tables](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html),
[NAT Gateways](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html),
[Network ACLs](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html) and
[Internet Gateway](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html).

This module provides recommended settings:

- Create a Subnet for each tier
- Create a Route Table for each tier
- Create a NAT gateway in each Availability Zone
- Unused Default Network ACL

## Usage

### Minimal

```hcl
module "vpc" {
  source     = "git::https://github.com/tmknom/terraform-aws-vpc.git?ref=tags/2.0.0"
  cidr_block = "10.255.0.0/16"
  name       = "example"

  public_subnet_cidr_blocks  = ["10.255.0.0/24", "10.255.1.0/24"]
  public_availability_zones  = ["ap-northeast-1a", "ap-northeast-1c"]
  private_subnet_cidr_blocks = ["10.255.64.0/24", "10.255.65.0/24"]
  private_availability_zones = ["ap-northeast-1a", "ap-northeast-1c"]
}
```

### Complete

```hcl
module "vpc" {
  source     = "git::https://github.com/tmknom/terraform-aws-vpc.git?ref=tags/2.0.0"
  cidr_block = "10.255.0.0/16"
  name       = "example"

  public_subnet_cidr_blocks  = ["10.255.0.0/24", "10.255.1.0/24"]
  public_availability_zones  = ["ap-northeast-1a", "ap-northeast-1c"]
  private_subnet_cidr_blocks = ["10.255.64.0/24", "10.255.65.0/24"]
  private_availability_zones = ["ap-northeast-1a", "ap-northeast-1c"]

  instance_tenancy        = "default"
  enable_dns_support      = false
  enable_dns_hostnames    = false
  map_public_ip_on_launch = false

  enabled_nat_gateway        = true
  enabled_single_nat_gateway = false

  tags = {
    Environment = "prod"
  }
}
```

## Examples

- [Minimal](https://github.com/tmknom/terraform-aws-vpc/tree/master/examples/minimal)
- [Complete](https://github.com/tmknom/terraform-aws-vpc/tree/master/examples/complete)
- [Single NAT Gateway](https://github.com/tmknom/terraform-aws-vpc/tree/master/examples/single_nat_gateway)
- [Disabled NAT Gateway](https://github.com/tmknom/terraform-aws-vpc/tree/master/examples/disabled_nat_gateway)

## Requirements

| Name      | Version |
| --------- | ------- |
| terraform | >= 0.12 |

## Providers

| Name | Version |
| ---- | ------- |
| aws  | n/a     |

## Inputs

| Name                       | Description                                                                                              | Type           | Default     | Required |
| -------------------------- | -------------------------------------------------------------------------------------------------------- | -------------- | ----------- | :------: |
| cidr_block                 | The CIDR block for the VPC.                                                                              | `string`       | n/a         |   yes    |
| name                       | The name for the VPC.                                                                                    | `string`       | n/a         |   yes    |
| enable_dns_hostnames       | A boolean flag to enable/disable DNS hostnames in the VPC.                                               | `string`       | `true`      |    no    |
| enable_dns_support         | A boolean flag to enable/disable DNS support in the VPC.                                                 | `string`       | `true`      |    no    |
| enabled_nat_gateway        | Set to false to prevent the module from creating NAT Gateway resources.                                  | `string`       | `true`      |    no    |
| enabled_single_nat_gateway | Set to true to create single NAT Gateway resource.                                                       | `string`       | `false`     |    no    |
| instance_tenancy           | A tenancy option for instances launched into the VPC.                                                    | `string`       | `"default"` |    no    |
| map_public_ip_on_launch    | Specify true to indicate that instances launched into the subnet should be assigned a public IP address. | `string`       | `true`      |    no    |
| private_availability_zones | The Availability Zones for the private subnets.                                                          | `list(string)` | `[]`        |    no    |
| private_subnet_cidr_blocks | The CIDR blocks for the private subnets.                                                                 | `list(string)` | `[]`        |    no    |
| public_availability_zones  | The Availability Zones for the public subnets.                                                           | `list(string)` | `[]`        |    no    |
| public_subnet_cidr_blocks  | The CIDR blocks for the public subnets.                                                                  | `list(string)` | `[]`        |    no    |
| tags                       | A mapping of tags to assign to all resources.                                                            | `map(string)`  | `{}`        |    no    |

## Outputs

| Name                                | Description                                                        |
| ----------------------------------- | ------------------------------------------------------------------ |
| eip_nat_gateway_ids                 | Contains the EIP allocation IDs.                                   |
| eip_nat_gateway_private_ips         | Contains the private IP addresses (if in VPC).                     |
| eip_nat_gateway_public_ips          | Contains the public IP addresses.                                  |
| internet_gateway_id                 | The ID of the Internet Gateway.                                    |
| nat_gateway_allocation_ids          | The Allocation IDs of the Elastic IP address for the gateways.     |
| nat_gateway_ids                     | The IDs of the NAT Gateways.                                       |
| nat_gateway_network_interface_ids   | The ENI IDs of the network interface created by the NAT gateways.  |
| nat_gateway_private_ips             | The private IP addresses of the NAT Gateways.                      |
| nat_gateway_public_ips              | The public IP addresses of the NAT Gateways.                       |
| nat_gateway_subnet_ids              | The Subnet IDs of the subnet in which the NAT gateways are placed. |
| private_egress_network_acl_rule_id  | The ID of the private egress network ACL Rule.                     |
| private_ingress_network_acl_rule_id | The ID of the private ingress network ACL Rule.                    |
| private_network_acl_id              | The ID of the private network ACL.                                 |
| private_route_table_association_ids | The IDs of the private associations.                               |
| private_route_table_ids             | The IDs of the private routing tables.                             |
| private_subnet_arns                 | The ARNs of the private subnets.                                   |
| private_subnet_availability_zones   | The Availability Zones for the private subnets.                    |
| private_subnet_cidr_blocks          | The CIDR blocks for the private subnets.                           |
| private_subnet_ids                  | The IDs of the private subnets.                                    |
| public_egress_network_acl_rule_id   | The ID of the public egress network ACL Rule.                      |
| public_ingress_network_acl_rule_id  | The ID of the public ingress network ACL Rule.                     |
| public_network_acl_id               | The ID of the public network ACL.                                  |
| public_route_table_association_ids  | The IDs of the public associations.                                |
| public_route_table_id               | The ID of the public routing table.                                |
| public_subnet_arns                  | The ARNs of the public subnets.                                    |
| public_subnet_availability_zones    | The Availability Zones for the public subnets.                     |
| public_subnet_cidr_blocks           | The CIDR blocks for the public subnets.                            |
| public_subnet_ids                   | The IDs of the public subnets.                                     |
| vpc_arn                             | Amazon Resource Name (ARN) of VPC.                                 |
| vpc_cidr_block                      | The CIDR block of the VPC.                                         |
| vpc_default_network_acl_id          | The ID of the network ACL created by default on VPC creation.      |
| vpc_default_route_table_id          | The ID of the route table created by default on VPC creation.      |
| vpc_default_security_group_id       | The ID of the security group created by default on VPC creation.   |
| vpc_enable_dns_hostnames            | Whether or not the VPC has DNS hostname support.                   |
| vpc_enable_dns_support              | Whether or not the VPC has DNS support.                            |
| vpc_id                              | The ID of the VPC.                                                 |
| vpc_instance_tenancy                | Tenancy of instances spin up within VPC.                           |
| vpc_main_route_table_id             | The ID of the main route table associated with this VPC.           |

## Development

### Requirements

- [Docker](https://www.docker.com/)

### Configure environment variables

```shell
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=ap-northeast-1
```

### Installation

```shell
git clone git@github.com:tmknom/terraform-aws-vpc.git
cd terraform-aws-vpc
make install
```

### Makefile targets

```text
apply-complete                 Run terraform apply examples/complete
apply-disabled-nat-gateway     Run terraform apply examples/disabled_nat_gateway
apply-minimal                  Run terraform apply examples/minimal
apply-single-nat-gateway       Run terraform apply examples/single_nat_gateway
check-format                   Check format code
clean                          Clean .terraform
destroy-complete               Run terraform destroy examples/complete
destroy-disabled-nat-gateway   Run terraform destroy examples/disabled_nat_gateway
destroy-minimal                Run terraform destroy examples/minimal
destroy-single-nat-gateway     Run terraform destroy examples/single_nat_gateway
diff                           Word diff
docs                           Generate docs
format                         Format code
help                           Show help
install                        Install requirements
lint                           Lint code
plan-complete                  Run terraform plan examples/complete
plan-disabled-nat-gateway      Run terraform plan examples/disabled_nat_gateway
plan-minimal                   Run terraform plan examples/minimal
plan-single-nat-gateway        Run terraform plan examples/single_nat_gateway
release                        Release GitHub and Terraform Module Registry
upgrade                        Upgrade makefile
```

### Releasing new versions

Bump VERSION file, and run `make release`.

### Terraform Module Registry

- <https://registry.terraform.io/modules/tmknom/vpc/aws>

## License

Apache 2 Licensed. See LICENSE for full details.
