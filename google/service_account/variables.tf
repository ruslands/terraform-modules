variable "name" {
  type        = string
  description = "Service account name"
}

variable "project_id" {
  default     = null
  type        = string
  description = "Google Project id"
}

variable "description" {
  default     = null
  type        = string
  description = "Service account description"
}

variable "display_name" {
  default     = null
  type        = string
  description = "Service account display name"
}

variable "disabled" {
  default     = false
  type        = bool
  description = "Disable service account"
}

variable "secret_manager_iam_roles" {
  default     = {}
  type        = map(list(string))
  description = "Map of Secret Manager IAM roles and secrets"
}
