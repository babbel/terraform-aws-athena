variable "athena_workgroup_tags" {
  type    = map(string)
  default = {}

  description = <<EOS
Map of tags assigned to the Athena workgroup created by this module.
EOS
}

variable "default_tags" {
  type    = map(string)
  default = {}

  description = <<EOS
Map of tags assigned to all AWS resources created by this module.
EOS
}

variable "force_destroy" {
  type    = bool
  default = false

  description = <<EOS
Whether to force destroy the workgroup and the S3 bucket.
EOS
}

variable "name" {
  type = string

  description = <<EOS
Name used for resources and depending resources.
EOS
}

variable "s3_bucket_tags" {
  type    = map(string)
  default = {}

  description = <<EOS
Map of tags assigned to the S3 bucket created by this module.
EOS
}

variable "selected_engine_version" {
  type    = string
  default = "AUTO"

  description = <<EOS
The workgroup's engine version.
EOS
}

variable "workgroup_bucket" {
  type = string

  description = <<EOS
The name of the bucket to contain the Athena work group's data.
EOS
}

variable "workspace_bucket_expiration_days" {
  type    = number
  default = 30

  description = <<EOS
The expiration days for objects in the workspace bucket in days. By default objects are expired 30 days after their creation. If set to null, expiration is disabled.
EOS
}

variable "workspace_bytes_scanned_cutoff" {
  type    = number
  default = 10 * 1024 * 1024 * 1024 * 1024 # 10TB

  description = <<EOS
The upper data usage limit (cutoff) for the amount of bytes a single query in the workgroup is allowed to scan. Defaults to 10 TB.
EOS
}
