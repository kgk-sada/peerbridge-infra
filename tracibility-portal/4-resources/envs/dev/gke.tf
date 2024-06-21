data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                          = "../../modules/gke"
  project_id                      = local.application_project_id
  name                            = var.cluster_name
  regional                        = true
  region                          = var.default_region
  network_project_id              = local.network_project_id
  network                         = var.network_name
  subnetwork                      = var.subnetwork_name
  ip_range_pods                   = local.pods_range_name
  ip_range_services               = local.svc_range_name
  release_channel                 = "REGULAR"
  enable_vertical_pod_autoscaling = true
  enable_private_endpoint         = true
  enable_private_nodes            = true
  master_ipv4_cidr_block          = "10.238.131.0/28"
  deploy_using_private_endpoint   = true
  master_global_access_enabled    = true 

  master_authorized_networks = [
    {
      cidr_block   = "10.0.0.0/22" #Change it to dynamically get values from Subnet
      display_name = "Internal-VPC" #Subnet Name 
    },
  ]
}

resource "google_compute_ssl_policy" "ssl-policy" {
  name            = "${var.cluster_name}-ssl-policy"
  project         = local.application_project_id
  profile         = "MODERN"
  min_tls_version = "TLS_1_2"
}

resource "google_compute_global_address" "lb_static_ip" {
  name = var.static_ip_name
  description = var.ip_description
  project = local.application_project_id
  address_type = "EXTERNAL"
}
