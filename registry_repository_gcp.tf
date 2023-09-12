module "registry_repository_gcp" {
  for_each = toset([
    "services",
  ])
  source = "./modules/google/registry_repository"

  repository_id = each.key
}
