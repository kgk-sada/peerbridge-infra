output "network_name" {
  value       = module.vpc.network_name
  description = "The Name of VPC to be created"
}

output "network_self_link" {
  value       = module.vpc.network_self_link
  description = "The Name of VPC to be created"
}

output "subnet_name" {
  value = module.vpc.subnets_names
}

output "subnets_ids" {
  value       = module.vpc.subnets_ids
  description = "The ID of subnets created"
}

output "subnets_self_links" {
  value       = module.vpc.subnets_self_links
  description = "The Self Links of subnets created"
}

output "secondary_ranges" {
  value = module.vpc.subnets_secondary_ranges
}
