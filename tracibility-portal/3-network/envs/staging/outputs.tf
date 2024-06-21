output "st_network_name" {
  value       = module.clinical_portal_network.network_name
  description = "The Name of VPC to be created"
}

output "st_network_self_link" {
  value       = module.clinical_portal_network.network_self_link
  description = "The Name of VPC to be created"
}

output "st_subnets_ids" {
  value       = module.clinical_portal_network.subnets_ids
  description = "The ID of subnets created"
}

output "st_subnets_secondary_ip_range" {
  value = module.clinical_portal_network.secondary_ranges
}

output "st_firewall_iap" {
  value       = module.firewall.allow_ingress_iap
  description = "Firewall IAP for network"
}

output "st_firewall_lb_hc" {
  value       = module.firewall.allow_ingress_lb_hc
  description = "Firewall LB HC for network"
}

output "st_subnetwork_name_01" {
  value = local.subnet_01
  description = "Staging Network Subnetwork-01 name"
}

output "st_subnetwork_name_02" {
  value = local.subnet_02
  description = "Staging Network Subnetwork-02 name"
}