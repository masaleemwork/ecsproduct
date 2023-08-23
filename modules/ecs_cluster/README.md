# ecs_cluster

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
| [aws_ecs_cluster.fargate_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.nginx_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.nginx_task_definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ecs_task_execution_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.ecs_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecr_image"></a> [ecr\_image](#input\_ecr\_image) | ARN for ECR image | `string` | n/a | yes |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | CloudWatch Log Group name for ECS | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | VPC region | `string` | `"eu-west-2"` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnet IDs for ECS cluster | `list(any)` | n/a | yes |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | Target group ARN for ALB | `string` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block to be used for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_security_group_id"></a> [ecs\_security\_group\_id](#output\_ecs\_security\_group\_id) | Returns the security group ID of the ECS cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
