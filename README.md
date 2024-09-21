# Athena

This module creates resources for querying with Athena.

The resources are: an Athena workgroup and an S3 bucket to keep
the workgroup's data. No table schema is created. This has to be done manually
by AWS console (cd. https://docs.aws.amazon.com/athena/latest/ug/creating-tables.html).

The bucket uses [default server-side encryption](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucket-encryption.html) with [Amazon S3-Managed Keys](https://docs.aws.amazon.com/AmazonS3/latest/userguide/serv-side-encryption.html).

For example a DML query creating a table supporting the ALB log format is
provided by [this documentation](https://docs.aws.amazon.com/athena/latest/ug/application-load-balancer-logs.html).

## Example

```tf
module "alb-athena-example" {
  source  = "babbel/athena/aws"
  version = "~> 3.0"

  name             = "alb-logs-example-production"
  workgroup_bucket = "athena-workgroup-alb-logs-example-production"
}
```
