output "stg_network_name" {
  value       = module.traceability_portal_network.network_name
  description = "The Name of VPC to be created"
}

output "stg_network_self_link" {
  value       = module.traceability_portal_network.network_self_link
  description = "The Name of VPC to be created"
}

output "stg_subnets_ids" {
  value       = module.traceability_portal_network.subnets_ids
  description = "The ID of subnets created"
}

output "stg_subnets_secondary_ip_range" {
  value = module.traceability_portal_network.secondary_ranges
}

output "stg_firewall_iap" {
  value       = module.firewall.allow_ingress_iap
  description = "Firewall IAP for network"
}

output "stg_firewall_lb_hc" {
  value       = module.firewall.allow_ingress_lb_hc
  description = "Firewall LB HC for network"
}

output "stg_subnetwork_name_01" {
  value = local.subnet_01
  description = "stg Network Subnetwork-01 name"
}

output "stg_subnetwork_name_02" {
  value = local.subnet_02
  description = "stg Network Subnetwork-02 name"
}

output "staging_subnetwork_self_links" {
  value = module.traceability_portal_network.subnets_self_links
  description = "Network Subnetworks self link"
}