output "athena_workgroup" {
  description = "Athena workgroup."

  value = aws_athena_workgroup.this
}

output "s3_bucket" {
  description = "S3 bucket for storing Athena data."

  value = aws_s3_bucket.athena-workspace
}

output "glue_catalog_database" {
  description = "Glue catalog database."

  value = aws_glue_catalog_database.this
}
