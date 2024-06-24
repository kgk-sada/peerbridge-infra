module "monitoring" {
  source = "../../modules/project"

  env              = var.env
  environment_code = var.environment_code
  application_name = "monitoring"
  project_prefix   = local.project_prefix
  org_id           = local.org_id
  billing_account  = local.billing_account
  folder_id        = google_folder.sub_folder["fldr-backend"].id
  activate_apis = [
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "billingbudgets.googleapis.com"
  ]


  labels = {
    environment      = var.env
    env_code         = var.environment_code
    application_name = "monitoring"
    billing_code     = var.env_billing_code
  }
}
