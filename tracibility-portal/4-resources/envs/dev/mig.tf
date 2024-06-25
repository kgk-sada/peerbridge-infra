# instance template
resource "google_compute_instance_template" "instance_template" {
  name         = "l7-ilb-mig-template"
  provider     = google-beta
  machine_type = "e2-standrd-4"


  network_interface {
    network    = data.google_compute_network.network.id
    subnetwork = data.google_compute_network.network.subnetworks_self_links[0]
    access_config {
      # add external ip to fetch packages
    }
  }
  disk {
    source_image = "windows-server-2016-dc-v20240612"
    auto_delete  = true
    boot         = true
    disk_size_gb = 100
    disk_type = "pd-ssd"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# MIG
resource "google_compute_region_instance_group_manager" "mig" {
  name     = var.mig_name
  provider = google-beta
  region   = "us-central1"
  version {
    instance_template = google_compute_instance_template.instance_template.id
    name              = "primary"
  }
  base_instance_name = "traceability-portal"
  target_size        = 1
  update_policy {
    type = "PROACTIVE"
    minimal_action = "REPLACE"
    max_surge_fixed = 3
    max_unavailable_fixed = 1 
  
  }
}




# resource "google_compute_instance" "gce" {
#   project         = local.application_project_id
#   name         = "traceability_portal"
#   machine_type = "e2-standard-4"
#   zone         = "us-central1-a"

#   boot_disk {
#     initialize_params {
#       size = 100
#       image = "windows-server-2016-dc-v20240612"
#     }
#   }

#   network_interface {
#     network = data.google_compute_network.network.id
#     subnetwork = data.google_compute_network.network.subnetworks_self_links[0]
#     # access_config {
#     #   // Ephemeral public IP
#     # }
#   }

#   service_account {
#     # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#     email  = module.bastion_host_service_account.email
#     scopes = ["cloud-platform"]
#   }
# }