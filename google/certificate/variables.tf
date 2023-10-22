variable "domains" {
  type        = list(string)
  description = "List of dns domains"
}

variable "scope" {
  type        = string
  default     = "DEFAULT"
  description = "Certificate scope (DEFAULT, EDGE_CACHE, ALL_REGIONS)"
}

variable "name" {
  type        = string
  description = "Certificate name"
}

variable "create_map" {
  type        = bool
  default     = false
  description = "Create certificate map"
}
