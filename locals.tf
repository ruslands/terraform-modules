locals {
  project_name            = "allpapers"
  main_domain             = "allpapers.online"
  development_domain_name = "development.${local.main_domain}"
  staging_domain_name     = "staging.${local.main_domain}"
  production_domain_name  = local.main_domain

  # extra domain names
  extra_main_domain             = "allpapers.app"
  extra_development_domain_name = "development.${local.extra_main_domain}"
  extra_staging_domain_name     = "staging.${local.extra_main_domain}"
  extra_production_domain_name  = local.extra_main_domain

  # resource tags
  common_tags = {
    project = local.project_name
  }
  development_tags = merge({
    environment = "development"
  }, local.common_tags)
  staging_tags = merge({
    environment = "staging"
  }, local.common_tags)
  production_tags = merge({
    environment = "production"
  }, local.common_tags)
}
