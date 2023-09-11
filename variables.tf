variable "aws_access_key" {
  type        = string
  sensitive   = true
  description = "AWS Access Key for Terraform"
}

variable "aws_secret_key" {
  type        = string
  sensitive   = true
  description = "AWS Secret Key for Terraform"
}

variable "google_credentials" {
  type        = string
  sensitive   = true
  description = "Contents of a Google service account key file in JSON format"
}
