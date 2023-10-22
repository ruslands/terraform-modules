output "service_account" {
  value       = google_service_account.this
  description = "API Gateway Service Account"
}

output "neg_id" {
  value = one(google_compute_region_network_endpoint_group.this[*].id)
}
