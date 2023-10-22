variable "name" {
  type        = string
  description = "API Gateway name"
}

variable "region" {
  type        = string
  default     = null
  description = "GCP Provider"
}

variable "openapi_content" {
  type        = string
  description = "Content of openapi.yaml"
}

variable "create_neg" {
  type        = bool
  default     = false
  description = "Create NEG"
}
