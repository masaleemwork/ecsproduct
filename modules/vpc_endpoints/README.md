# vpc_endpoints

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
| [aws_vpc_endpoint.ec2messages-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ecr-api-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ecr-dkr-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.kms-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.logs-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.monitoring-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ssm-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ssmmessages-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Region in which the endpoints will be placed | `string` | `"eu-west-2"` | no |
| <a name="input_enable_ec2messages_endpoint"></a> [enable\_ec2messages\_endpoint](#input\_enable\_ec2messages\_endpoint) | Feature switch for EC2 Messages endpoint | `bool` | `true` | no |
| <a name="input_enable_ecr_api_endpoint"></a> [enable\_ecr\_api\_endpoint](#input\_enable\_ecr\_api\_endpoint) | Feature switch for ECR API endpoint | `bool` | `true` | no |
| <a name="input_enable_ecr_dkr_endpoint"></a> [enable\_ecr\_dkr\_endpoint](#input\_enable\_ecr\_dkr\_endpoint) | Feature switch for ECR DKR endpoint | `bool` | `true` | no |
| <a name="input_enable_kms_endpoint"></a> [enable\_kms\_endpoint](#input\_enable\_kms\_endpoint) | Feature switch for KMS endpoint | `bool` | `true` | no |
| <a name="input_enable_logs_endpoint"></a> [enable\_logs\_endpoint](#input\_enable\_logs\_endpoint) | Feature switch for Logs endpoint | `bool` | `true` | no |
| <a name="input_enable_monitoring_endpoint"></a> [enable\_monitoring\_endpoint](#input\_enable\_monitoring\_endpoint) | Feature switch for Monitoring endpoint | `bool` | `true` | no |
| <a name="input_enable_s3_endpoint"></a> [enable\_s3\_endpoint](#input\_enable\_s3\_endpoint) | Feature switch for S3 endpoint | `bool` | `true` | no |
| <a name="input_enable_ssm_endpoint"></a> [enable\_ssm\_endpoint](#input\_enable\_ssm\_endpoint) | Feature switch for SSM endpoint | `bool` | `true` | no |
| <a name="input_enable_ssmmessages_endpoint"></a> [enable\_ssmmessages\_endpoint](#input\_enable\_ssmmessages\_endpoint) | Feature switch for SSM Messages endpoint | `bool` | `true` | no |
| <a name="input_route_table_ids"></a> [route\_table\_ids](#input\_route\_table\_ids) | Route table IDs for S3 endpoint | `list(any)` | `[]` | no |
| <a name="input_security_groups_cw"></a> [security\_groups\_cw](#input\_security\_groups\_cw) | Security group IDs for CloudWatch endpoints | `list(any)` | `[]` | no |
| <a name="input_security_groups_ecr"></a> [security\_groups\_ecr](#input\_security\_groups\_ecr) | Security group IDs for ECR endpoints | `list(any)` | `[]` | no |
| <a name="input_security_groups_ssm_ec2_kms"></a> [security\_groups\_ssm\_ec2\_kms](#input\_security\_groups\_ssm\_ec2\_kms) | Security group IDs for SSM, EC2 and KMS endpoints | `list(any)` | `[]` | no |
| <a name="input_subnet_ids_ecr_cw"></a> [subnet\_ids\_ecr\_cw](#input\_subnet\_ids\_ecr\_cw) | Subnet IDs for ECR and CloudWatch endpoints | `list(any)` | `[]` | no |
| <a name="input_subnet_ids_ssm_ec2_kms"></a> [subnet\_ids\_ssm\_ec2\_kms](#input\_subnet\_ids\_ssm\_ec2\_kms) | Subnet IDs for SSM, EC2 and KMS endpoints | `list(any)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | `""` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
