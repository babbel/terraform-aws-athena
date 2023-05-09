variable "name" {
  description = "Name used for resources and depending resources."
  type        = string
}

variable "resource_specific_tags" {
  description = "Map of tags to assign to specific resources supporting tags. Merged with `tags`."
  type        = map(map(string))
  default     = {}
}

variable "selected_engine_version" {
  description = "The work group's engine version."
  type        = string
  default     = "AUTO"
}

variable "tags" {
  description = "Map of tags to assign to all resources supporting tags."
  type        = map(string)
}

variable "workspace_bucket_expiration_days" {
  description = "The expiration days for objects in the workspace bucket in days. By default objects are expired 30 days after their creation. If set to null, expiration is disabled."
  type        = number
  default     = 30
}

variable "workspace_bucket_prefix" {
  description = "The name of the bucket to contain the Athena work group's data is composed of a prefix and the name."
  type        = string
}

variable "workspace_bytes_scanned_cutoff" {
  description = "The upper data usage limit (cutoff) for the amount of bytes a single query in the workgroup is allowed to scan. Defaults to 10 TB."
  type        = number
  default     = 10 * 1024 * 1024 * 1024 * 1024 # 10TB
}

variable "force_destroy" {
  description = "Whether to force destroy the workgroup and the S3 bucket."
  type        = bool
  default     = false
}

variable "create_glue_database" {
  description = "Whether to create a Glue database for the workgroup."
  type        = bool
  default     = true
}
