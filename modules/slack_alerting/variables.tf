variable "flow_id" {
  type        = string
  description = "Flow ID for the slack alerting flow"
}

variable "namespace_prefix" {
  type        = string
  description = "Namespace prefix for the flow"
}

variable "silent_flows" {
  type = list(object({
    flow_id   = string
    namespace = string
  }))
  description = "list of flows to be silent"
  default     = []
}

variable "slack_webhook_url" {
  type        = string
  description = "Slack webhook URL to send alerts to"
}

variable "slack_channel" {
  type        = string
  description = "Slack channel to send alerts to, should start with leading #: #my-channel"
}
