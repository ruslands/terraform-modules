module "bucket_gitlab_terraform_gcp" {
  source = "git::https://github.com/terraform-google-modules/terraform-google-cloud-storage.git//modules/simple_bucket?ref=v4.0.1"

  name          = local.gitlab_terraform_bucket_name
  project_id    = local.google_project_id
  location      = local.google_region
  versioning    = false
  force_destroy = true
}
