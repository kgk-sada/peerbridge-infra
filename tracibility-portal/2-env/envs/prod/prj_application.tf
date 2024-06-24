module "application" {
  source = "../../modules/project"

  env              = var.env
  environment_code = var.environment_code
  application_name = "backend"
  project_prefix   = local.project_prefix
  org_id           = local.org_id
  billing_account  = local.billing_account
  folder_id        = google_folder.sub_folder["fldr-backend"].id

  activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "serviceusage.googleapis.com",
    "storage.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "billingbudgets.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "servicenetworking.googleapis.com",
    "sqladmin.googleapis.com",
  ]


  labels = {
    environment      = var.env
    env_code         = var.environment_code
    application_name = "backend"
    billing_code     = var.env_billing_code
  }
}