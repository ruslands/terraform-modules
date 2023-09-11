module "cloud_run" {
  source = "git::https://github.com/GoogleCloudPlatform/terraform-google-cloud-run.git?ref=v0.9.1"

  # Required variables
  service_name = "development-backend"
  project_id   = local.google_project_id
  location     = local.google_region
  image        = "docker.io/jmalloc/echo-server"
  #   image                  = "gcr.io/cloudrun/hello"

  members = [
    module.development_api_gateway_google.service_account.member,
  ]
}
