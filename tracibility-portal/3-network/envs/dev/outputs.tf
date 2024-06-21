output "dev_network_name" {
  value       = module.traceability_portal_network.network_name
  description = "The Name of VPC to be created"
}

output "dev_network_self_link" {
  value       = module.traceability_portal_network.network_self_link
  description = "The Name of VPC to be created"
}

output "dev_subnets_ids" {
  value       = module.traceability_portal_network.subnets_ids
  description = "The ID of subnets created"
}

output "dev_subnets_secondary_ip_range" {
  value = module.traceability_portal_network.secondary_ranges
}

output "dev_firewall_iap" {
  value       = module.firewall.allow_ingress_iap
  description = "Firewall IAP for network"
}

output "dev_firewall_lb_hc" {
  value       = module.firewall.allow_ingress_lb_hc
  description = "Firewall LB HC for network"
}

output "dev_subnetwork_name_01" {
  value = local.subnet_01
  description = "Dev Network Subnetwork-01 name"
}

output "dev_subnetwork_name_02" {
  value = local.subnet_02
  description = "Dev Network Subnetwork-02 name"
}