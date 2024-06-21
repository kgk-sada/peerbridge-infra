output "allow_ingress_iap" {
  value       = resource.google_compute_firewall.allow_ingress_iap
  description = "The firewall for IAP ingress"
}

output "allow_ingress_lb_hc" {
  value       = resource.google_compute_firewall.allow_ingress_lb_hc
  description = "The firewall for Google Load Balancer and Health Check ingress"
}
