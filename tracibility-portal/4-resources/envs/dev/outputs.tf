# output "kubernetes_endpoint" {
#   description = "The cluster endpoint"
#   sensitive   = true
#   value       = module.gke.endpoint
# }

# output "cluster_name" {
#   description = "Cluster name"
#   value       = module.gke.name
# }

# output "location" {
#   value = module.gke.location
# }

# output "master_kubernetes_version" {
#   description = "Kubernetes version of the master"
#   value       = module.gke.master_version
# }

# output "service_account" {
#   description = "The service account to default running nodes as if not overridden in `node_pools`."
#   value       = module.gke.service_account
# }

# output "region" {
#   description = "The region in which the cluster resides"
#   value       = module.gke.region
# }

# output "zones" {
#   description = "List of zones in which the cluster resides"
#   value       = module.gke.zones
# }

# output "root_password" {
#   description = "Root password from Cloud SQL"
#    value       = module.sql_instance.random_password.root-password.value
# }

# output "user_password" {
#   description = "User password from Cloud SQL"
#   value       = module.sql_instance.random_password.user-password.value
# }

output "root_password" {
  description = "Root password from Cloud SQL"
   value       = data.google_secret_manager_secret_version.sqlroot_password.secret_data

}
