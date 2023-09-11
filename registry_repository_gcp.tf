module "registry_repository_gcp" {
  for_each = toset([
    local.project_name,
  ])
  source = "./modules/google/registry_repository"

  repository_id = each.key
}
