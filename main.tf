data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_glue_catalog_database" "this" {
  name        = var.name
  description = "Database for analysing ${var.name} with Athena"
}

resource "aws_s3_bucket" "athena-workspace" {
  bucket = join("-", [var.workspace_bucket_prefix, var.name])

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = var.tags
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

  configuration {
    enforce_workgroup_configuration    = true
    publish_cloudwatch_metrics_enabled = false

    bytes_scanned_cutoff_per_query = var.workspace_bytes_scanned_cutoff

    result_configuration {
      output_location = "s3://${aws_s3_bucket.athena-workspace.bucket}/"
    }
  }

  tags = var.tags
}
