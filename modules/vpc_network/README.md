# vpc_network

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.20.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_flow_log.vpc-flow-logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_role.flow_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.flow_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_route_table.private_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_rta](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.flow_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_flow_logs_group_arn"></a> [flow\_logs\_group\_arn](#input\_flow\_logs\_group\_arn) | ARN of the flow logs group | `string` | n/a | yes |
| <a name="input_subnet_count"></a> [subnet\_count](#input\_subnet\_count) | Number of subnets to use per AZ | `number` | `"3"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR to be used for the VPC | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_az_list"></a> [az\_list](#output\_az\_list) | Outputs the AZ list |
| <a name="output_subnet_list"></a> [subnet\_list](#output\_subnet\_list) | Outputs the subnet list |
| <a name="output_subnet_rts"></a> [subnet\_rts](#output\_subnet\_rts) | Outputs the name for the private route table |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | Outputs the private subnets |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | Outputs the VPC ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
