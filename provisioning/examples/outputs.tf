output "name_servers" {
  value = google_dns_managed_zone.main.name_servers
}

output "github-actions-admin-credentials" {
  sensitive = true
  value     = aws_iam_access_key.github-actions-admin
}

output "github-actions-owner-credentials-json" {
  sensitive = true
  value     = base64decode(google_service_account_key.github-actions-owner.private_key)
}

output "ses-mail-sender-credentials" {
  sensitive = true
  value     = aws_iam_access_key.mail-sender
}
