terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 4.64.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "= 4.81.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "= 4.81.0"
    }
  }
  backend "http" {
    address        = "https://gitlab.com/api/v4/projects/46113981/terraform/state/terraform-infra"
    lock_address   = "https://gitlab.com/api/v4/projects/46113981/terraform/state/terraform-infra/lock"
    lock_method    = "POST"
    unlock_address = "https://gitlab.com/api/v4/projects/46113981/terraform/state/terraform-infra/lock"
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

provider "google" {
  project     = local.google_project_id
  region      = local.google_region
  credentials = var.google_credentials
}

provider "google-beta" {
  project     = local.google_project_id
  region      = local.google_region
  credentials = var.google_credentials
}
