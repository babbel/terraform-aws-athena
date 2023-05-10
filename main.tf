resource "aws_glue_catalog_database" "this" {
  count = var.create_glue_database ? 1 : 0
  // dashes in glue table names may cause errors when running Athena DDL queries.
  // cf. https://aws.amazon.com/premiumsupport/knowledge-center/parse-exception-missing-eof-athena/
  name = replace(var.name, "-", "_")

  description = "Database for analysing ${var.name} with Athena"
}

resource "aws_s3_bucket" "athena-workspace" {
  bucket = var.workgroup_bucket == null ? "${var.workspace_bucket_prefix}-${var.name}" : var.workgroup_bucket

  force_destroy = var.force_destroy

  tags = merge(
    var.tags,
    lookup(var.resource_specific_tags, "s3_bucket", {})
  )
}

resource "aws_s3_bucket_server_side_encryption_configuration" "athena-workspace" {
  bucket = aws_s3_bucket.athena-workspace.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "athena-workspace" {
  count = var.workspace_bucket_expiration_days != null ? 1 : 0

  bucket = aws_s3_bucket.athena-workspace.bucket

  rule {
    id     = "expire"
    status = "Enabled"

    # applies to all objects in the bucket:
    # omitting `filter` is effectively the same, but it's a bit confusing,
    # as it will generate a filter with an empty path prefix.
    filter {}

    expiration {
      days = var.workspace_bucket_expiration_days
    }
  }
}

resource "aws_s3_bucket_public_access_block" "athena-workspace" {
  bucket = aws_s3_bucket.athena-workspace.bucket

  block_public_acls  = true
  ignore_public_acls = true

  block_public_policy     = true
  restrict_public_buckets = true # forbids setting cross-account access policies as well
}

resource "aws_athena_workgroup" "this" {
  name = var.name

  force_destroy = var.force_destroy

  configuration {
    enforce_workgroup_configuration    = true
    publish_cloudwatch_metrics_enabled = false

    engine_version {
      selected_engine_version = var.selected_engine_version
    }

    bytes_scanned_cutoff_per_query = var.workspace_bytes_scanned_cutoff

    result_configuration {
      output_location = "s3://${aws_s3_bucket.athena-workspace.bucket}/"
    }
  }

  tags = merge(
    var.tags,
    lookup(var.resource_specific_tags, "athena_workgroup", {})
  )
}
