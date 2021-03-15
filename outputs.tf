data "aws_iam_policy_document" "iam-policy-document-athena-workspace-use" {
  source_policy_documents = [
    data.aws_iam_policy_document.athena-workgroup-readonly-access.json,
    data.aws_iam_policy_document.glue-catalog-database-manage-tables.json,
    data.aws_iam_policy_document.s3-athena-workspace-fullaccess.json,
  ]
}

output "iam-policy-document-athena-workspace-use" {
  description = "Policy document permitting to create new tables and query in workspace."

  value = data.aws_iam_policy_document.iam-policy-document-athena-workspace-use.json
}

output "athena_workgroup" {
  description = "Athena workgroup."

  value = aws_athena_workgroup.this
}

output "bucket" {
  description = "S3 bucket for storing Athena data."

  value = aws_s3_bucket.athena-workspace
}

output "glue_catalog_database" {
  description = "Glue catalog database."

  value = aws_glue_catalog_database.this
}
