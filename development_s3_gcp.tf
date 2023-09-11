module "development_buckets_gcp" {
  for_each = local.development_s3_buckets
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
