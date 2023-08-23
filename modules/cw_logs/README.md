# cw_logs

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
| [aws_cloudwatch_log_group.ec2-logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.fargate-logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.flow-logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | ARN of the KMS master key | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_log_group"></a> [ec2\_log\_group](#output\_ec2\_log\_group) | Outputs the name for EC2 log group |
| <a name="output_ecs_log_group"></a> [ecs\_log\_group](#output\_ecs\_log\_group) | Outputs the name for fargate log group |
| <a name="output_flow_log_group"></a> [flow\_log\_group](#output\_flow\_log\_group) | Outputs the name for flow log group |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
