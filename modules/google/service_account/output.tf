output "email" {
  value       = google_service_account.this.email
  description = "Service account email"
}

output "member" {
  value       = google_service_account.this.member
  description = "Service account member"
}
