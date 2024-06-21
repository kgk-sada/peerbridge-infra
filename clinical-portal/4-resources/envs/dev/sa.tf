 data "google_project" "service_project" {
   project_id = local.application_project_id
 }

resource "google_project_iam_binding" "gke-iam" {
  project = local.network_project_id
  role    = "roles/compute.networkUser"

  members = [
    "serviceAccount:service-${data.google_project.service_project.number}@container-engine-robot.iam.gserviceaccount.com",
  ]
}

resource "google_project_iam_binding" "gke-iam-1" {
  project = local.network_project_id
  role    = "roles/container.hostServiceAgentUser"

  members = [
    "serviceAccount:service-${data.google_project.service_project.number}@container-engine-robot.iam.gserviceaccount.com",
  ]
}

module "bastion_host_service_account" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 3.0"
  project_id    = local.application_project_id
  names         = ["sa-bastion-host"]
  display_name  = "Bastion Host Service Account"
  description   = "Service Account for Bastion Host"
  project_roles = [
    "${local.application_project_id}=>roles/compute.admin",
    "${local.application_project_id}=>roles/compute.networkAdmin",
    "${local.application_project_id}=>roles/compute.securityAdmin",
    "${local.application_project_id}=>roles/compute.storageAdmin",
    "${local.application_project_id}=>roles/container.clusterAdmin",
    "${local.application_project_id}=>roles/logging.logWriter",
    "${local.application_project_id}=>roles/monitoring.metricWriter",
    "${local.application_project_id}=>roles/monitoring.viewer",
    "${local.application_project_id}=>roles/stackdriver.resourceMetadata.writer",
    "${local.application_project_id}=>roles/container.admin",
    "${local.application_project_id}=>roles/container.clusterAdmin",
    ]
}


