output "prod_network_name" {
  value       = module.clinical_portal_network.network_name
  description = "The Name of VPC to be created"
}

output "prod_network_self_link" {
  value       = module.clinical_portal_network.network_self_link
  description = "The Name of VPC to be created"
}

output "prod_subnets_ids" {
  value       = module.clinical_portal_network.subnets_ids
  description = "The ID of subnets created"
}

output "prod_subnets_secondary_ip_range" {
  value = module.clinical_portal_network.secondary_ranges
}

output "prod_firewall_iap" {
  value       = module.firewall.allow_ingress_iap
  description = "Firewall IAP for network"
}

output "prod_firewall_lb_hc" {
  value       = module.firewall.allow_ingress_lb_hc
  description = "Firewall LB HC for network"
}

output "prod_subnetwork_name_01" {
  value = local.subnet_01
  description = "Network Subnetwork-01 name"
}

output "prod_subnetwork_name_02" {
  value = local.subnet_02
  description = "Network Subnetwork-02 name"
}