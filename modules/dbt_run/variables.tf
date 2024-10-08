variable "flow_id" {
  type        = string
  description = "Flow ID for the dbt run flow"
}

variable "description" {
  type        = string
  description = "Description of the flow"
}

variable "namespace" {
  type        = string
  default     = "blueprint"
  description = "Namespace of the flow"
}

variable "disabled" {
  type        = bool
  default     = false
  description = "Whether the flow is disabled"
}

variable "labels" {
  type        = map(string)
  description = "Labels to apply to the flow"
  default     = {}
}

variable "priority" {
  type        = string
  default     = null
  description = "Priority tag to apply to the flow"
}

variable "trigger" {
  type        = string
  description = "String containing triggers sections of the flow"
  default     = ""
}

variable "github_repo_url" {
  type        = string
  description = "Github repository to clone"
}

variable "git_branch" {
  type        = string
  description = "Branch to checkout"
  default     = "main"
}

variable "dbt_profile_name" {
  type        = string
  description = "Name of the dbt profile to use"
  default     = "default"
}

variable "dbt_commands" {
  description = "dbt commands to run"
  type        = list(string)
}

variable "dbt_max_retry_attempt" {
  type        = number
  description = "Number of retries for dbt run performed before the system stops retrying."
  default     = 1
}
