# output "dns_records" {
#   value = [
#     for i in google_certificate_manager_dns_authorization.this : {
#       name = i.name
#       type = i.type
#       data = i.data
#     }
#   ]
#   description = "DNS records to insert"
# }

output "id" {
  value       = google_certificate_manager_certificate.this.id
  description = "Certificate ID"
}

output "certificate_map_id" {
  value       = one(google_certificate_manager_certificate_map.this[*].id)
  description = "Certificate map ID"
}
