variable "flow_id" {
  type = string
}

variable "namespace" {
  type = string
}

variable "description" {
  type = string
}

variable "postgres_host" {
  type        = string
  description = "Postgres Host"
}

variable "postgres_user" {
  type        = string
  description = "Postgres User"
}

variable "postgres_password_secret" {
  type        = string
  description = "Postgres Secret"
}

variable "postgres_database" {
  type        = string
  description = "Database Name"
}

variable "sql_query" {
  type        = string
  description = "SQL Query to perform purge"
}

variable "show_result_in_logs" {
  type        = bool
  description = "Log the result of the query"
  default     = false
}

variable "trigger" {
  type        = string
  description = "String containing triggers sections of the flow"
  default     = ""
}
