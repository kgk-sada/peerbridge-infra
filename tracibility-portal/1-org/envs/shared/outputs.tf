output "org_id" {
  value       = local.org_id
  description = "The organization id"
}

output "parent_resource_id" {
  value       = local.parent_resource_id
  description = "The parent resource id"
}

output "parent_resource_type" {
  value       = local.parent_resource_type
  description = "The parent resource type"
}

output "common_folder_name" {
  value       = google_folder.common.name
  description = "The common folder name"
}

output "org_audit_logs_project_id" {
  value       = module.org_audit_logs.project_id
  description = "The org audit logs project ID"
}

output "org_billing_logs_project_id" {
  value       = module.org_billing_logs.project_id
  description = "The org billing logs project ID"
}

output "domains_to_allow" {
  value       = var.domains_to_allow
  description = "The list of domains to allow users from in IAM."
}

output "logs_export_storage_bucket_name" {
  value       = module.logs_export.storage_destination_name
  description = "The storage bucket for destination of log exports"
}

output "logs_export_logbucket_name" {
  value       = module.logs_export.logbucket_destination_name
  description = "The log bucket for destination of log exports. See https://cloud.google.com/logging/docs/routing/overview#buckets"
}

output "cloud_build_service_account" {
  value       = module.cloud_build_service_account.email
  description = "cloud_build_service_account"
}


output "cloud_build_service_account_sa" {
  value       = module.cloud_build_service_account.service_account
  description = "cloud_build_service_account"
}

output "devops-project_id" {
  value       = module.devops.project_id
  description = "devops-project_id"
}