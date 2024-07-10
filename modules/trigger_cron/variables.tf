variable "cron_expression" {
  type        = string
  description = "Cron expression or supported expression like : @hourly"
}

variable "cron_name" {
  type        = string
  description = "Provide a description of your Cron expression for simplicity"
}

variable "late_maximum_delay" {
  type        = string
  description = "Allow to disable auto-backfill : if the schedule didn't start after this delay, the execution will be skip."
}
