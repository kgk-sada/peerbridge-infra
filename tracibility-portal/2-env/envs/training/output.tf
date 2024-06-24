output "application_project_id" {
  value       = module.application.project
  description = "The Project ID of application project."
}

output "monitoring_project_id" {
  value       = module.monitoring.project
  description = "The Project ID of monitoring project."
}

output "secret_project_id" {
  value       = module.secret.project
  description = "The Project ID of secret project."
}

output "network_project_id" {
  value       = module.network_host.project
  description = "The Project ID of network project."
}