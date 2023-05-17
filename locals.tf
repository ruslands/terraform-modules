locals {
  project_name            = "allpapers"
  main_domain             = "allpapers.online"
  development_domain_name = "development.${local.main_domain}"
  staging_domain_name     = "staging.${local.main_domain}"
  production_domain_name  = local.main_domain
}
