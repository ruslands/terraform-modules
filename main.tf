terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 4.64.0"
    }
  }
  backend "http" {
    address        = "https://gitlab.com/api/v4/projects/45484112/terraform/state/terraform-infra"
    lock_address   = "https://gitlab.com/api/v4/projects/45484112/terraform/state/terraform-infra/lock"
    lock_method    = "POST"
    unlock_address = "https://gitlab.com/api/v4/projects/45484112/terraform/state/terraform-infra/lock"
    unlock_method  = "DELETE"
    retry_wait_min = 5
  }
  required_version = ">= 1.4.0"
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
