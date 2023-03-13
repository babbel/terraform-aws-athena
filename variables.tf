variable "name" {
  type = string

  description = "Name used for resources and depending resources."
}

variable "resource_specific_tags" {
  description = "Map of tags to assign to specific resources supporting tags. Merged with `tags`."

  type = map(map(string))

  default = {}
}

variable "selected_engine_version" {
  default = "AUTO"

  description = "The work group's engine version."
}

variable "tags" {
  description = "Map of tags to assign to all resources supporting tags."

  type = map(string)
}

variable "workspace_bucket_expiration_days" {
  default = 30

  description = "The expiration days for objects in the workspace bucket in days. By default objects are expired 30 days after their creation. If set to null, expiration is disabled."
}

variable "workspace_bucket_prefix" {
  description = "The name of the bucket to contain the Athena work group's data is composed of a prefix and the name."

  type = string
}

variable "workspace_bytes_scanned_cutoff" {
  description = "The upper data usage limit (cutoff) for the amount of bytes a single query in the workgroup is allowed to scan. Defaults to 10 TB."

  type = number

  default = 10 * 1024 * 1024 * 1024 * 1024 # 10TB
}
