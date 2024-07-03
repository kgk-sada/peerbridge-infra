/******************************************
  Audit Logs - IAM
*****************************************/

locals {
  enabling_data_logs = var.data_access_logs_enabled ? ["DATA_WRITE", "DATA_READ"] : []
}

resource "google_organization_iam_audit_config" "org_config" {
  count   = local.parent_folder == "" ? 1 : 0
  org_id  = local.org_id
  service = "allServices"

  ###################################################################################################
  ### Audit logs can generate costs, to know more about it,
  ### check the official documentation: https://cloud.google.com/stackdriver/pricing#logging-costs
  ### To know more about audit logs, you can find more infos
  ### here https://cloud.google.com/logging/docs/audit/configure-data-access
  ### To enable DATA_READ and DATA_WRITE audit logs, set `data_access_logs_enabled` to true
  ### ADMIN_READ logs are enabled by default.
  ####################################################################################################
  dynamic "audit_log_config" {
    for_each = setunion(local.enabling_data_logs, ["ADMIN_READ"])
    content {
      log_type = audit_log_config.key
    }
  }
}

resource "google_folder_iam_audit_config" "folder_config" {
  count   = local.parent_folder != "" ? 1 : 0
  folder  = "folders/${local.parent_folder}"
  service = "allServices"

  ###################################################################################################
  ### Audit logs can generate costs, to know more about it,
  ### check the official documentation: https://cloud.google.com/stackdriver/pricing#logging-costs
  ### To know more about audit logs, you can find more infos
  ### here https://cloud.google.com/logging/docs/audit/configure-data-access
  ### To enable DATA_READ and DATA_WRITE audit logs, set `data_access_logs_enabled` to true
  ### ADMIN_READ logs are enabled by default.
  ####################################################################################################
  dynamic "audit_log_config" {
    for_each = setunion(local.enabling_data_logs, ["ADMIN_READ"])
    content {
      log_type = audit_log_config.key
    }
  }
}

/******************************************
  Billing Cloud Console - IAM
*****************************************/

resource "google_organization_iam_member" "billing_viewer" {
  org_id = local.org_id
  role   = "roles/billing.viewer"
  member = "group:${var.billing_data_users}"
}

/******************************************
 Groups permissions according to SFB (Section 6.2 - Users and groups) - IAM
*****************************************/

resource "google_folder_iam_member" "network_admin" {
  count  = var.gcp_groups.platform_viewer != null && local.parent_folder != "" ? 1 : 0
  folder = "folders/${local.parent_folder}"
  role   = "roles/compute.networkAdmin"
  member = "group:${var.gcp_groups.network_admin}"
}

module "parent_iam_member" {
  source = "../../modules/parent-iam-member"

  parent_type = "folder"
  parent_id   = "folders/${local.parent_folder}"
  roles       = var.network_admin_roles
  member      = "group:${var.gcp_groups.network_admin}"
}

/******************************************
 Privileged accounts permissions according to SFB (Section 6.3 - Privileged identities)
*****************************************/

resource "google_organization_iam_member" "org_admin_user" {
  count  = var.gcp_user.org_admin != null && local.parent_folder == "" ? 1 : 0
  org_id = local.org_id
  role   = "roles/resourcemanager.organizationAdmin"
  member = "user:${var.gcp_user.org_admin}"
}

resource "google_folder_iam_member" "org_admin_user" {
  count  = var.gcp_user.org_admin != null && local.parent_folder != "" ? 1 : 0
  folder = "folders/${local.parent_folder}"
  role   = "roles/resourcemanager.folderAdmin"
  member = "user:${var.gcp_user.org_admin}"
}

resource "google_billing_account_iam_member" "billing_admin_user" {
  count              = var.gcp_user.billing_admin != null ? 1 : 0
  billing_account_id = local.billing_account
  role               = "roles/billing.admin"
  member             = "user:${var.gcp_user.billing_admin}"
}

/******************************************
  Monitoring - IAM
*****************************************/

resource "google_folder_iam_member" "monitoring_viewer" {
  count  = var.gcp_user.org_admin != null && local.parent_folder != "" ? 1 : 0
  folder = "folders/${local.parent_folder}"
  role   = "roles/monitoring.viewer"
  member = "user:${var.gcp_groups.monitoring_users}"
}

resource "google_folder_iam_member" "log_viewer" {
  count  = var.gcp_user.org_admin != null && local.parent_folder != "" ? 1 : 0
  folder = "folders/${local.parent_folder}"
  role   = "roles/logging.privateLogViewer"
  member = "user:${var.gcp_groups.monitoring_users}"
}

resource "google_folder_iam_member" "error_reporting_viewer" {
  count  = var.gcp_user.org_admin != null && local.parent_folder != "" ? 1 : 0
  folder = "folders/${local.parent_folder}"
  role   = "roles/errorreporting.viewer"
  member = "user:${var.gcp_groups.monitoring_users}"
}


module "cloud_build_service_account" {
  source        = "terraform-google-modules/service-accounts/google"
  depends_on = [ module.devops ]
  version       = "~> 4.2"
  project_id    = module.devops.project_id
  names         = ["sa-cloud-build-ci-cd"]
  display_name  = "Cloud Build CI/CD Service Account"
  description   = "Service Account for Cloud Build CI/CD"
  project_roles = [
    "${module.devops.project_id}=>roles/compute.admin",
    "${module.devops.project_id}=>roles/compute.storageAdmin",
    "${module.devops.project_id}=>roles/logging.logWriter",
    "${module.devops.project_id}=>roles/monitoring.metricWriter",
    "${module.devops.project_id}=>roles/cloudbuild.builds.editor",
    "${module.devops.project_id}=>roles/storage.admin",
    ]
}
# Give logs writer role to cloud build sa
resource "google_project_iam_member" "cloud_build_sa_logs_writer" {
  depends_on = [ module.devops ]
  project = module.devops.project_id
  role    = "roles/cloudbuild.builds.builder"
  member  = "serviceAccount:${module.devops.project_number}@cloudbuild.gserviceaccount.com"
}