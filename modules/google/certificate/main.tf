resource "google_certificate_manager_certificate" "this" {
  name  = var.name
  scope = var.scope
  managed {
    domains            = [for i in google_certificate_manager_dns_authorization.this : i.domain]
    dns_authorizations = [for i in google_certificate_manager_dns_authorization.this : i.id]
  }
  provider = google-beta
}

resource "google_certificate_manager_dns_authorization" "this" {
  for_each = toset(var.domains)
  name     = replace(each.key, ".", "-")
  domain   = each.key
  provider = google-beta
}

resource "google_certificate_manager_certificate_map" "this" {
  count    = var.create_map ? 1 : 0
  name     = "${var.name}-map"
  provider = google-beta
}

resource "google_certificate_manager_certificate_map_entry" "this" {
  count        = var.create_map ? 1 : 0
  name         = var.name
  map          = google_certificate_manager_certificate_map.this[0].name
  certificates = [google_certificate_manager_certificate.this.id]
  matcher      = "PRIMARY"
  provider     = google-beta
}
