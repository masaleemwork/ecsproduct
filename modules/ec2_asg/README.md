# ec2_asg

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
| [aws_autoscaling_group.ec2_autoscaling_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_iam_instance_profile.ec2_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ec2_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.kms_ec2_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.ec2_managed_policy_cw_agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ec2_managed_policy_ssm_directory](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ec2_managed_policy_ssm_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_launch_template.ec2_launch_template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_security_group.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI ID for EC2 instances | `string` | `"ami-07650ecb0de9bd731"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Region in which the VPC will be placed | `string` | `"eu-west-2"` | no |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | CloudWatch Log Group name for EC2 | `string` | n/a | yes |
| <a name="input_subnet_ids_asg"></a> [subnet\_ids\_asg](#input\_subnet\_ids\_asg) | Subnet IDs for ASG | `list(any)` | `[]` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR to be used for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_sg"></a> [ec2\_sg](#output\_ec2\_sg) | Returns the security group of the EC2 instance |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
