resource "google_compute_instance" "bastion_host" {
  project         = local.application_project_id
  name         = "bastion-host-for-cloudsql"
  machine_type = "e2-standard-16"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      size = 100
      image = "windows-server-2016-dc-v20240612"
    }
  }

  network_interface {
    network = data.google_compute_network.network.id
    subnetwork = data.google_compute_network.network.subnetworks_self_links[0]
    # access_config {
    #   // Ephemeral public IP
    # }
  }

  lifecycle {
    ignore_changes = [
      metadata
    ]
  
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = module.bastion_host_service_account.email
    scopes = ["cloud-platform"]
  }
}