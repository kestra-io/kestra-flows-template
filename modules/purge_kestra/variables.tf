variable "flow_id" {
  type    = string
  default = "kestra_purge"
}

variable "namespace" {
  type = string
}

variable "postgres_host" {
  type        = string
  description = "Postgres Host"
}

variable "postgres_password_secret" {
  type        = string
  description = "Postgres Secret"
}

variable "namespace_to_purge" {
  type        = string
  description = "Namespace to purge"
}

variable "retention_months" {
  type        = number
  description = "Number of months to keep logs"
  default     = 2
}

variable "trigger" {
  type        = string
  description = "String containing triggers sections of the flow"
  default     = ""
}
