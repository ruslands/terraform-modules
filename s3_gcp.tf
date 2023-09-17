locals {
  gcp_buckets = toset([
    "${local.project_name}-frontend-app-client-development",
    "${local.project_name}-frontend-app-admin-development",
    "${local.project_name}-frontend-landing-development",
    "${local.project_name}-frontend-app-client-staging",
    "${local.project_name}-frontend-app-admin-staging",
    "${local.project_name}-frontend-landing-staging",
    "${local.project_name}-frontend-app-client-production",
    "${local.project_name}-frontend-app-admin-production",
    "${local.project_name}-frontend-landing-production",
    "${local.project_name}-media",
  ])
}

module "frontend_buckets_gcp" {
  for_each = local.gcp_buckets
  source   = "git::https://github.com/terraform-google-modules/terraform-google-cloud-storage.git//modules/simple_bucket?ref=v4.0.1"

  name          = each.key
  project_id    = local.google_project_id
  location      = local.google_region
  versioning    = false
  force_destroy = true
  website = {
    main_page_suffix = "index.html"
    not_found_page   = "index.html"
  }
  iam_members = [
    {
      role   = "roles/storage.objectViewer"
      member = "allUsers"
    },
  ]
}
