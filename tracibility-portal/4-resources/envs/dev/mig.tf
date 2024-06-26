# instance template
resource "google_compute_instance_template" "instance_template" {
  name         = "l7-ilb-mig-template"
  provider     = google-beta
  project      = var.gcp_bucket_project_id
  machine_type = "e2-standard-4"


  network_interface {
    network = local.network_self_link
    subnetwork = local.subnet_01_self_link
    # access_config {
    #   # add external ip to fetch packages
    # }
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
  project  = var.gcp_bucket_project_id
  region   = "us-central1"
  version {
    instance_template = google_compute_instance_template.instance_template.id
    name              = "primary"
  }
  auto_healing_policies {
    initial_delay_sec = 300
    health_check      =  google_compute_health_check.autohealing.id
  }
  named_port {
    name = "tcp"
    port = 3389
  }
  
  base_instance_name = "traceability-portal"
  target_size        = 1
  update_policy {
    type = "PROACTIVE"
    minimal_action = "REPLACE"
    max_surge_fixed = 3
  }
}

resource "google_compute_health_check" "autohealing" {
  name                = "autohealing-health-check-mig"
  check_interval_sec  = 30
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10

  tcp_health_check {
    # request_path = "/"
    port         = "3389"
  }
}

# Granting Google APIs Service Agent compute.subnetworks.use permission at Network project

data "google_project" "project_number" {
  project_id = local.application_project_id
}

resource "google_project_iam_member" "mig" {
  project = local.network_project_id
  role    = "roles/compute.networkUser"
  member  = "serviceAccount:${data.google_project.project_number.number}@cloudservices.gserviceaccount.com"
}