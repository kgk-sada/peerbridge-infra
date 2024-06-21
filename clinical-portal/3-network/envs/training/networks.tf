locals {
  subnet_01 = "sb-${var.environment_code}-backend-01"
  subnet_02 = "sb-${var.environment_code}-backend-02"
}

module "clinical_portal_network" {
  source             = "../../modules/network"
  project_id         = local.network_project_id
  network_name       = "vpc-${var.environment_code}-backend"
  default_region     = var.default_region
  environment_code   = var.environment_code
  nat_enabled        = true
  router_log_filter  = "TRANSLATIONS_ONLY"
  router_log_enabled = false
  subnets = [
    {
      subnet_name           = local.subnet_01
      subnet_ip             = "10.0.24.0/22"
      subnet_region         = var.default_region
      subnet_private_access = "true"
      subnet_flow_logs      = "false"

    },
    {
      subnet_name           = local.subnet_02
      subnet_ip             = "10.0.28.0/22"
      subnet_region         = var.default_region
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
    },
  ]
  secondary_ranges = {
    (local.subnet_01) = [
      {
        range_name    = "${local.subnet_01}-pods"
        ip_cidr_range = "172.20.4.0/22"
      },
      {
        range_name    = "${local.subnet_01}-svc"
        ip_cidr_range = "172.20.8.0/22"
      },
    ]
  }
}

resource "google_compute_shared_vpc_host_project" "host" {
  project = local.network_project_id
}

resource "google_compute_shared_vpc_service_project" "application" {
  service_project = local.application_project_id
  host_project    = google_compute_shared_vpc_host_project.host.project
}