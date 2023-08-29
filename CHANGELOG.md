# Changelog

## v3.0.2

- [Provide empty map as default for `tags` variable](https://github.com/babbel/terraform-aws-athena/pull/35)

## v3.0.1

- [Update README.md](https://github.com/babbel/terraform-aws-athena/pull/34)

## v3.0.0

- [Drop `glue_catalog_database` from module and replace `workspace_bucket_prefix` by `workgroup_bucket` ](https://github.com/babbel/terraform-aws-athena/pull/32)

## v2.4.0

- [Configure object ownership for the bucket](https://github.com/babbel/terraform-aws-athena/pull/31)

## v2.3.0

- [Relax version constraints for modules ](https://github.com/babbel/terraform-aws-athena/pull/29)

## v2.2.0

- [Add force_destroy option to cleanly delete S3 bucket and workshop](https://github.com/babbel/terraform-aws-athena/pull/27)

## v2.1.0

- [Add selected_engine_version](https://github.com/babbel/terraform-aws-athena/pull/26)

## v2.0.2

- [Create S3 lifecycle config with empty filter](https://github.com/babbel/terraform-aws-athena/pull/21)

## v2.0.1

- [Fix for_each attribute](https://github.com/babbel/terraform-aws-athena/pull/18)

## v2.0.0

- [Add support for hashicorp/aws v4 in new major version](https://github.com/babbel/terraform-aws-athena/pull/17)

## v1.4.0

- [Add expiry for objects in workspace bucket](https://github.com/babbel/terraform-aws-athena/pull/10)

## v1.3.0

- [Add support for resource-specific tags](https://github.com/babbel/terraform-aws-athena/pull/5)

## v1.2.0

Substitute dashes by underscores in glue catalog database names.

## v1.1.1

Remove unused IAM policy documents.

## v1.1.0

- [Export resources created by this module](https://github.com/babbel/terraform-aws-athena/pull/2)
- [Remove policy document `iam-policy-document-athena-workspace-use` output](https://github.com/babbel/terraform-aws-athena/pull/2)

## v1.0.0

- [Initial version](https://github.com/babbel/terraform-aws-athena/pull/1)
