# Athena

This module creates resources for querying with Athena.

The resources are: a Glue database, an Athena workgroup and an S3 bucket to keep
the workgroup's data. No table schema is created. This has to be done manually
by AWS console (cd. https://docs.aws.amazon.com/athena/latest/ug/creating-tables.html).

For example a DML query creating a table supporting the ALB log format is
provided by [this documentation](https://docs.aws.amazon.com/athena/latest/ug/application-load-balancer-logs.html).

## Example

```tf
module "alb-athena-example" {
  source = "https://babbel.s3.amazonaws.com/lessonnine/shared.terraform/...COMMIT_SHA.../alb/athena.zip"

  name                    = "alb-logs-example-production"
  workspace_bucket_prefix = "athena-workgroup"

  tags = {
    service     = "example"
    environment = "production"
  }
}
```
