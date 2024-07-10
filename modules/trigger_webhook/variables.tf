variable "webhook_name" {
  type        = string
  description = "Name of the Webhook trigger"
  default     = null
}

variable "key" {
  type        = string
  description = "Key used to authorize trigger"
}
