resource "aws_acm_certificate" "wildcard" {
  domain_name       = local.main_domain
  validation_method = "DNS"

  subject_alternative_names = [
    local.main_domain,
    "*.${local.main_domain}",
  ]
}

resource "aws_acm_certificate" "extra_wildcard" {
  domain_name       = local.extra_main_domain
  validation_method = "DNS"

  subject_alternative_names = [
    local.extra_main_domain,
    "*.${local.extra_main_domain}",
  ]
}
