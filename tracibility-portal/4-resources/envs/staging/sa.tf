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
    "${local.application_project_id}=>roles/monitoring.viewer",
    "${local.application_project_id}=>roles/secretmanager.secretAccessor",
    "${local.application_project_id}=>roles/eventarc.eventReceiver",
    "${local.application_project_id}=>roles/storage.objectViewer",
    ]
}


# Give role to cloud build sa
resource "google_project_iam_member" "sa-for-devops" {
  project = local.devops_project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${module.traceability_app_service_account.email}"
}

# Give role to cloud build sa
resource "google_project_iam_member" "sa-for-devops-1" {
  project = local.devops_project_id
  role    = "roles/compute.storageAdmin"
  member  = "serviceAccount:${module.traceability_app_service_account.email}"
}


# Give role to cloud build sa
resource "google_project_iam_member" "sa-for-devops-2" {
  project = local.devops_project_id
  role    = "roles/compute.admin"
  member  = "serviceAccount:${module.traceability_app_service_account.email}"
}

# Give role to cloud build sa
resource "google_project_iam_member" "sa-for-devops-3" {
  project = local.devops_project_id
  role    = "roles/compute.serviceAgent"
  member  = "serviceAccount:${module.traceability_app_service_account.email}"
}

# Give role to cloud build sa
resource "google_project_iam_member" "sa-for-devops-4" {
  project = local.devops_project_id
  role    = "roles/compute.instanceAdmin.v1"
  member  = "serviceAccount:${module.traceability_app_service_account.email}"
}

# Give role to cloud build sa
resource "google_project_iam_member" "sa-for-devops-5" {
  project = local.devops_project_id
  role    = "roles/eventarc.eventReceiver"
  member  = "serviceAccount:${module.traceability_app_service_account.email}"
}
# Give role to cloud build sa
resource "google_project_iam_member" "sa-for-devops-6" {
  project = local.devops_project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${module.traceability_app_service_account.email}"
}