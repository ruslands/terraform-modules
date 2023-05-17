resource "aws_acm_certificate" "wildcard" {
  domain_name       = local.main_domain
  validation_method = "DNS"

  subject_alternative_names = [
    local.main_domain,
    "*.${local.main_domain}",
  ]
}
