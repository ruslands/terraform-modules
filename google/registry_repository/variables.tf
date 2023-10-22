variable "location" {
  default     = null
  type        = string
  description = "Repository location (region)"
}

variable "repository_id" {
  type        = string
  description = "The last part of the repository name"
}

variable "description" {
  default     = null
  type        = string
  description = "Repository description"
}
