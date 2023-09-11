module "registry_repository_gcp" {
  for_each = toset([
    "backend",
  ])
  source = "./modules/google/registry_repository"

  repository_id = each.key
}
