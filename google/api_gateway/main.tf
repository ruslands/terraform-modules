resource "google_api_gateway_api" "this" {
  provider     = google-beta
  api_id       = var.name
  display_name = var.name
}

resource "google_api_gateway_api_config" "this" {
  provider             = google-beta
  api                  = google_api_gateway_api.this.api_id
  api_config_id_prefix = var.name
  display_name         = "${var.name}-config"

  openapi_documents {
    document {
      path     = "spec.yaml"
      contents = base64encode(var.openapi_content)
    }
  }
  gateway_config {
    backend_config {
      google_service_account = google_service_account.this.id
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_api_gateway_gateway" "this" {
  provider     = google-beta
  region       = var.region
  api_config   = google_api_gateway_api_config.this.id
  gateway_id   = var.name
  display_name = var.name
}

resource "google_service_account" "this" {
  provider     = google-beta
  account_id   = "${var.name}-sa"
  display_name = "A service account for ${var.name} API Gateway"
}

resource "google_compute_region_network_endpoint_group" "this" {
  count                 = var.create_neg ? 1 : 0
  name                  = "${var.name}-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  serverless_deployment {
    platform = "apigateway.googleapis.com"
    resource = google_api_gateway_gateway.this.gateway_id
  }
  provider = google-beta
}
