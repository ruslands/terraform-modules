module "development_sa_backend_gcp" {
  source     = "./modules/google/service_account"
  project_id = local.google_project_id
  name       = "development-backend-sa"
  secret_manager_iam_roles = {
    "roles/secretmanager.secretAccessor" = [
      "development",
      "test-secret"
    ]
  }
}
