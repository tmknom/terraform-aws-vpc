# terraform-aws-vpc

[![CircleCI](https://circleci.com/gh/tmknom/terraform-aws-vpc.svg?style=svg)](https://circleci.com/gh/tmknom/terraform-aws-vpc)
[![GitHub tag](https://img.shields.io/github/tag/tmknom/terraform-aws-vpc.svg)](https://registry.terraform.io/modules/tmknom/vpc/aws)
[![License](https://img.shields.io/github/license/tmknom/terraform-aws-vpc.svg)](https://opensource.org/licenses/Apache-2.0)

Terraform module which creates VPC resources on AWS.

## Description

Provision [VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html),
[Subnets](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html),
[Route Tables](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html),
[Network ACLs](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html),
[Internet Gateways](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html).
This module provides recommended settings.

- Create a Subnet for each tier
- Create a Route Table for each tier
- Unused Default Network ACL

## Usage

### Minimal

```hcl
module "vpc" {
  source     = "git::https://github.com/tmknom/terraform-aws-vpc.git?ref=tags/1.0.0"
  cidr_block = "10.255.0.0/16"
  name       = "minimal"

  public_subnet_cidr_blocks  = ["10.255.0.0/24", "10.255.1.0/24"]
  public_availability_zones  = ["ap-northeast-1a", "ap-northeast-1c"]
  private_subnet_cidr_blocks = ["10.255.64.0/24", "10.255.65.0/24"]
  private_availability_zones = ["ap-northeast-1a", "ap-northeast-1c"]
}
```

### Complete

```hcl
module "vpc" {
  source     = "git::https://github.com/tmknom/terraform-aws-vpc.git?ref=tags/1.0.0"
  cidr_block = "192.168.0.0/16"
  name       = "complete"

  public_subnet_cidr_blocks  = ["192.168.0.0/24", "192.168.1.0/24"]
  public_availability_zones  = ["ap-northeast-1a", "ap-northeast-1c"]
  private_subnet_cidr_blocks = ["192.168.64.0/24", "192.168.65.0/24"]
  private_availability_zones = ["ap-northeast-1a", "ap-northeast-1c"]

  instance_tenancy        = "default"
  enable_dns_support      = false
  enable_dns_hostnames    = false
  map_public_ip_on_launch = false

  enabled_nat_gateway        = false
  enabled_single_nat_gateway = false

  tags = {
    Environment = "prod"
  }
}
```

## Examples

- [Minimal](https://github.com/tmknom/terraform-aws-vpc/tree/master/examples/minimal)
- [Complete](https://github.com/tmknom/terraform-aws-vpc/tree/master/examples/complete)

## Inputs

| Name                       | Description                                                                                              |  Type  |  Default  | Required |
| -------------------------- | -------------------------------------------------------------------------------------------------------- | :----: | :-------: | :------: |
| cidr_block                 | The CIDR block for the VPC.                                                                              | string |     -     |   yes    |
| name                       | The name for the VPC.                                                                                    | string |     -     |   yes    |
| enable_dns_hostnames       | A boolean flag to enable/disable DNS hostnames in the VPC.                                               | string |  `true`   |    no    |
| enable_dns_support         | A boolean flag to enable/disable DNS support in the VPC.                                                 | string |  `true`   |    no    |
| enabled_nat_gateway        | Set to false to prevent the module from creating NAT Gateway resources.                                  | string |  `true`   |    no    |
| enabled_single_nat_gateway | Set to true to create single NAT Gateway resource.                                                       | string |  `false`  |    no    |
| instance_tenancy           | A tenancy option for instances launched into the VPC.                                                    | string | `default` |    no    |
| map_public_ip_on_launch    | Specify true to indicate that instances launched into the subnet should be assigned a public IP address. | string |  `true`   |    no    |
| private_availability_zones | The Availability Zones for the private subnets.                                                          |  list  |   `[]`    |    no    |
| private_subnet_cidr_blocks | The CIDR blocks for the private subnets.                                                                 |  list  |   `[]`    |    no    |
| public_availability_zones  | The Availability Zones for the public subnets.                                                           |  list  |   `[]`    |    no    |
| public_subnet_cidr_blocks  | The CIDR blocks for the public subnets.                                                                  |  list  |   `[]`    |    no    |
| tags                       | A mapping of tags to assign to all resources.                                                            |  map   |   `{}`    |    no    |

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
check-format                   Check format code
cibuild                        Execute CI build
clean                          Clean .terraform
docs                           Generate docs
format                         Format code
help                           Show help
install                        Install requirements
lint                           Lint code
release                        Release GitHub and Terraform Module Registry
terraform-apply-complete       Run terraform apply examples/complete
terraform-apply-minimal        Run terraform apply examples/minimal
terraform-destroy-complete     Run terraform destroy examples/complete
terraform-destroy-minimal      Run terraform destroy examples/minimal
terraform-plan-complete        Run terraform plan examples/complete
terraform-plan-minimal         Run terraform plan examples/minimal
upgrade                        Upgrade makefile
```

### Releasing new versions

Bump VERSION file, and run `make release`.

### Terraform Module Registry

- <https://registry.terraform.io/modules/tmknom/vpc/aws>

## License

Apache 2 Licensed. See LICENSE for full details.
