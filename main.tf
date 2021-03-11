data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
resource "aws_glue_catalog_database" "this" {
  name        = var.name
  description = "Database for analysing ${var.name} with Athena"
}

data "aws_iam_policy_document" "glue-catalog-database-manage-tables" {
  statement {
    actions = [
      "glue:CreateTable",
      "glue:UpdateTable",
      "glue:DeleteTable",
    ]

    resources = [
      # https://docs.aws.amazon.com/glue/latest/dg/glue-specifying-resource-arns.html
      "arn:aws:glue:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:catalog",
      "arn:aws:glue:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:database/${aws_glue_catalog_database.this.name}",
      "arn:aws:glue:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/${aws_glue_catalog_database.this.name}/*",
    ]
  }
}
resource "aws_s3_bucket" "athena-workspace" {
  bucket = join("-", [var.workspace_bucket_prefix, var.name])

  tags = var.tags
}

data "aws_iam_policy_document" "s3-athena-workspace-fullaccess" {
  statement {
    actions   = ["s3:List*", "s3:Get*"]
    resources = [aws_s3_bucket.athena-workspace.arn]
  }

  statement {
    actions   = ["s3:*"]
    resources = ["${aws_s3_bucket.athena-workspace.arn}/*"]
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

data "aws_iam_policy_document" "athena-workgroup-readonly-access" {
  statement {
    actions = [
      "athena:GetCatalogs",
      "athena:GetExecutionEngine",
      "athena:GetExecutionEngines",
      "athena:GetNamespace",
      "athena:GetNamespaces",
      "athena:GetTable",
      "athena:GetTables",
      "athena:ListWorkGroups",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "athena:BatchGetNamedQuery",
      "athena:BatchGetQueryExecution",
      "athena:CreateNamedQuery",
      "athena:DeleteNamedQuery",
      "athena:GetNamedQuery",
      "athena:GetQueryExecution",
      "athena:GetQueryResults",
      "athena:GetQueryResultsStream",
      "athena:GetWorkGroup",
      "athena:ListNamedQueries",
      "athena:ListQueryExecutions",
      "athena:StartQueryExecution",
      "athena:StopQueryExecution",
    ]

    resources = [aws_athena_workgroup.this.arn]
  }
}
