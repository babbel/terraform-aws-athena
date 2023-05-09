# Athena

This module creates resources for querying with Athena.

The resources are: a Glue database, an Athena workgroup and an S3 bucket to keep
the workgroup's data. No table schema is created. This has to be done manually
by AWS console (cd. https://docs.aws.amazon.com/athena/latest/ug/creating-tables.html).

The bucket uses [default server-side encryption](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucket-encryption.html) with [Amazon S3-Managed Keys](https://docs.aws.amazon.com/AmazonS3/latest/userguide/serv-side-encryption.html).

For example a DML query creating a table supporting the ALB log format is
provided by [this documentation](https://docs.aws.amazon.com/athena/latest/ug/application-load-balancer-logs.html).

## Example

```tf
module "alb-athena-example" {
  source  = "babbel/athena/aws"
  version = "~> 2.0"

  name                    = "alb-logs-example-production"
  workspace_bucket_prefix = "athena-workgroup"

  tags = {
    app = "example"
    env = "production"
  }

  resource_specific_tags = {
    s3_bucket = {
      owner = "athena"
    }
  }
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.66.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_athena_workgroup.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/athena_workgroup) | resource |
| [aws_glue_catalog_database.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_database) | resource |
| [aws_s3_bucket.athena-workspace](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.athena-workspace](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_public_access_block.athena-workspace](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.athena-workspace](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_glue_database"></a> [create\_glue\_database](#input\_create\_glue\_database) | Whether to create a Glue database for the workgroup. | `bool` | `true` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Whether to force destroy the workgroup and the S3 bucket. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name used for resources and depending resources. | `string` | n/a | yes |
| <a name="input_resource_specific_tags"></a> [resource\_specific\_tags](#input\_resource\_specific\_tags) | Map of tags to assign to specific resources supporting tags. Merged with `tags`. | `map(map(string))` | `{}` | no |
| <a name="input_selected_engine_version"></a> [selected\_engine\_version](#input\_selected\_engine\_version) | The work group's engine version. | `string` | `"AUTO"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to all resources supporting tags. | `map(string)` | n/a | yes |
| <a name="input_workspace_bucket_expiration_days"></a> [workspace\_bucket\_expiration\_days](#input\_workspace\_bucket\_expiration\_days) | The expiration days for objects in the workspace bucket in days. By default objects are expired 30 days after their creation. If set to null, expiration is disabled. | `number` | `30` | no |
| <a name="input_workspace_bucket_prefix"></a> [workspace\_bucket\_prefix](#input\_workspace\_bucket\_prefix) | The name of the bucket to contain the Athena work group's data is composed of a prefix and the name. | `string` | n/a | yes |
| <a name="input_workspace_bytes_scanned_cutoff"></a> [workspace\_bytes\_scanned\_cutoff](#input\_workspace\_bytes\_scanned\_cutoff) | The upper data usage limit (cutoff) for the amount of bytes a single query in the workgroup is allowed to scan. Defaults to 10 TB. | `number` | `10995116277760` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_athena_workgroup"></a> [athena\_workgroup](#output\_athena\_workgroup) | Athena workgroup. |
| <a name="output_glue_catalog_database"></a> [glue\_catalog\_database](#output\_glue\_catalog\_database) | Glue catalog database. |
| <a name="output_s3_bucket"></a> [s3\_bucket](#output\_s3\_bucket) | S3 bucket for storing Athena data. |
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
