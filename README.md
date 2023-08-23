# ecsproduct

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.7.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | ./modules/alb | n/a |
| <a name="module_cw_logs"></a> [cw\_logs](#module\_cw\_logs) | ./modules/cw_logs | n/a |
| <a name="module_ec2_asg"></a> [ec2\_asg](#module\_ec2\_asg) | ./modules/ec2_asg | n/a |
| <a name="module_ecs_cluster"></a> [ecs\_cluster](#module\_ecs\_cluster) | ./modules/ecs_cluster | n/a |
| <a name="module_vpc_endpoints"></a> [vpc\_endpoints](#module\_vpc\_endpoints) | ./modules/vpc_endpoints | n/a |
| <a name="module_vpc_network"></a> [vpc\_network](#module\_vpc\_network) | ./modules/vpc_network | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_kms_key.kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Region in which the VPC will be placed | `string` | `"eu-west-2"` | no |
| <a name="input_ecr_image"></a> [ecr\_image](#input\_ecr\_image) | ARN for ECR image | `string` | `"917892242604.dkr.ecr.eu-west-2.amazonaws.com/nginx"` | no |
| <a name="input_enable_ec2messages_endpoint"></a> [enable\_ec2messages\_endpoint](#input\_enable\_ec2messages\_endpoint) | Feature switch for EC2 Messages endpoint | `bool` | `true` | no |
| <a name="input_enable_ecr_api_endpoint"></a> [enable\_ecr\_api\_endpoint](#input\_enable\_ecr\_api\_endpoint) | Feature switch for ECR API endpoint | `bool` | `true` | no |
| <a name="input_enable_ecr_dkr_endpoint"></a> [enable\_ecr\_dkr\_endpoint](#input\_enable\_ecr\_dkr\_endpoint) | Feature switch for ECR DKR endpoint | `bool` | `true` | no |
| <a name="input_enable_kms_endpoint"></a> [enable\_kms\_endpoint](#input\_enable\_kms\_endpoint) | Feature switch for KMS endpoint | `bool` | `true` | no |
| <a name="input_enable_logs_endpoint"></a> [enable\_logs\_endpoint](#input\_enable\_logs\_endpoint) | Feature switch for Logs endpoint | `bool` | `true` | no |
| <a name="input_enable_monitoring_endpoint"></a> [enable\_monitoring\_endpoint](#input\_enable\_monitoring\_endpoint) | Feature switch for Monitoring endpoint | `bool` | `true` | no |
| <a name="input_enable_s3_endpoint"></a> [enable\_s3\_endpoint](#input\_enable\_s3\_endpoint) | Feature switch for S3 endpoint | `bool` | `true` | no |
| <a name="input_enable_ssm_endpoint"></a> [enable\_ssm\_endpoint](#input\_enable\_ssm\_endpoint) | Feature switch for SSM endpoint | `bool` | `true` | no |
| <a name="input_enable_ssmmessages_endpoint"></a> [enable\_ssmmessages\_endpoint](#input\_enable\_ssmmessages\_endpoint) | Feature switch for SSM Messages endpoint | `bool` | `true` | no |
| <a name="input_subnet_count"></a> [subnet\_count](#input\_subnet\_count) | Number of subnets to use per AZ | `number` | `"3"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR to be used for the VPC | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | Output for application load balancer DNS name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
