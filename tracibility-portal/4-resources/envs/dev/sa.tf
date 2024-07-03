 data "google_project" "service_project" {
   project_id = local.application_project_id
 }

module "bastion_host_service_account" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 4.2"
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

module "traceability_app_service_account" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 4.2"
  project_id    = local.application_project_id
  names         = ["sa-traceability-app-host"]
  display_name  = "TP App Host Service Account"
  description   = "Service Account for TP APP Host"
  project_roles = [
    "${local.application_project_id}=>roles/compute.admin",
    "${local.application_project_id}=>roles/compute.storageAdmin",
    "${local.application_project_id}=>roles/logging.logWriter",
    "${local.application_project_id}=>roles/monitoring.metricWriter",
    "${local.application_project_id}=>roles/monitoring.viewer"
    ]
}