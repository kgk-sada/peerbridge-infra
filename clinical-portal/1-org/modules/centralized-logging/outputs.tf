output "storage_destination_name" {
  description = "The resource name for the destination Storage."
  value       = try(module.destination_storage[0].resource_name, "")
}

output "logbucket_destination_name" {
  description = "The resource name for the destination Log Bucket."
  value       = try(module.destination_logbucket[0].resource_name, "")
}
