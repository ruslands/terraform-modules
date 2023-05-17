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
