locals {
  hub_and_spoke_roles = [
    "roles/compute.instanceAdmin",
    "roles/iam.serviceAccountAdmin",
    "roles/resourcemanager.projectIamAdmin",
    "roles/iam.serviceAccountUser",
  ]
}

# Projects for log sinks
module "org_audit_logs" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 14.0"

  random_project_id        = true
  random_project_id_length = 4
  default_service_account  = "deprivilege"
  name                     = "${local.project_prefix}-c-logging-tp"
  org_id                   = local.org_id
  billing_account          = local.billing_account
  folder_id                = google_folder.common.id
  activate_apis            = ["logging.googleapis.com", "billingbudgets.googleapis.com"]

  labels = {
    environment      = "common"
    application_name = "org-logging-tp"
    billing_code     = "common"
    environment_code = "c"
  }
  budget_alert_spent_percents = var.project_budget.org_audit_logs_alert_spent_percents
  budget_amount               = var.project_budget.org_audit_logs_budget_amount
}

module "org_billing_logs" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 14.0"

  random_project_id        = true
  random_project_id_length = 4
  default_service_account  = "deprivilege"
  name                     = "${local.project_prefix}-c-billing-log-tp"
  org_id                   = local.org_id
  billing_account          = local.billing_account
  folder_id                = google_folder.common.id
  activate_apis            = ["logging.googleapis.com", "billingbudgets.googleapis.com"]

  labels = {
    environment      = "common"
    application_name = "org-logging-tp"
    billing_code     = "common"
    environment_code = "c"
  }
  budget_alert_spent_percents = var.project_budget.org_billing_logs_alert_spent_percents
  budget_amount               = var.project_budget.org_billing_logs_budget_amount
}


module "devops" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 14.0"

  random_project_id        = true
  random_project_id_length = 4
  default_service_account  = "deprivilege"
  name                     = "${local.project_prefix}-c-devops-tp"
  org_id                   = local.org_id
  billing_account          = local.billing_account
  folder_id                = google_folder.common.id
  activate_apis            = ["logging.googleapis.com", "billingbudgets.googleapis.com", "artifactregistry.googleapis.com", "cloudbuild.googleapis.com", "secretmanager.googleapis.com"]

  labels = {
    environment      = "common"
    application_name = "org-devops-tp"
    billing_code     = "common"
    environment_code = "c"
  }
  budget_alert_spent_percents = var.project_budget.org_billing_logs_alert_spent_percents
  budget_amount               = var.project_budget.org_billing_logs_budget_amount
}