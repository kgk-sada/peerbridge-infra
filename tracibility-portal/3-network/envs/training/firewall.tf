module "firewall" {
  source           = "../../modules/firewall"
  project_id       = local.network_project_id
  network_name     = module.traceability_portal_network.network_name
  environment_code = var.environment_code
  app_name         = "traceability-portal"
}