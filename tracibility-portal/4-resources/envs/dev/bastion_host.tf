# data "google_compute_network" "network" {
#   name = var.network_name
#   project = local.network_project_id
# }

# resource "google_compute_instance" "bastion_host" {
#   project         = local.application_project_id
#   name         = "bastion-host-for-gke"
#   machine_type = "e2-medium"
#   zone         = "us-central1-a"

#   boot_disk {
#     initialize_params {
#       image = "debian-11-bullseye-v20230814"
#     }
#   }

#   network_interface {
#     network = data.google_compute_network.network.id
#     subnetwork = data.google_compute_network.network.subnetworks_self_links[0]
#     access_config {
#       // Ephemeral public IP
#     }
#   }

# #   metadata_startup_script = "echo hi > /test.txt"

#   service_account {
#     # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#     email  = module.bastion_host_service_account.email
#     scopes = ["cloud-platform"]
#   }
# }
