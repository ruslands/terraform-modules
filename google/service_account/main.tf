locals {
  roles_secrets_mapping = merge([
    for role, secrets in var.secret_manager_iam_roles : {
      for secret_id in secrets : "${role}-${secret_id}" => {
        secret_id = secret_id
        role      = role
      }
    }
  ]...)
}

resource "google_service_account" "this" {
  account_id   = var.name
  display_name = var.display_name
  project      = var.project_id
  description  = var.description
  disabled     = var.disabled
}

resource "google_secret_manager_secret_iam_member" "this" {
  for_each  = local.roles_secrets_mapping
  role      = each.value.role
  secret_id = each.value.secret_id
  member    = google_service_account.this.member
  project   = var.project_id
}
