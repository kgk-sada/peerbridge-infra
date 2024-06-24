resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  project       = local.network_project_id
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = local.network_self_link
}


resource "google_service_networking_connection" "default" {
  network                 = local.network_self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}


data "google_secret_manager_secret" "sqlroot_password" {
  secret_id = "projects/1092774812152/secrets/sqlroot_password"
  project   = "prj-d-network-host-tp-nf3m"
}

module "sql_instance" {
  source = "GoogleCloudPlatform/sql-db/google//modules/mssql"
  version = "16.1.0"

  project_id = local.application_project_id
  region     = var.default_region

  name     = var.instance_name
  db_name           = "default"
  root_password     = data.google_secret_manager_secret.sqlroot_password.secret_id
  database_version  = "SQLSERVER_2022_ENTERPRISE"
  tier              = "db-custom-2-3840"
  disk_type         = "PD_SSD"
  availability_type = "ZONAL"
  

  ip_configuration  =  {
  "allocated_ip_range": null,
  "authorized_networks": [],
  "ipv4_enabled": false,
  "private_network": local.network_self_link,
  "require_ssl": null
}
}