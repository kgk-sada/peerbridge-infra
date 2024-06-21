module "secret" {
  source = "../../modules/project"

  env              = var.env
  environment_code = var.environment_code
  application_name = "secret"
  project_prefix   = local.project_prefix
  org_id           = local.org_id
  billing_account  = local.billing_account
  folder_id        = google_folder.sub_folder["fldr-backend"].id
  activate_apis = [
    "compute.googleapis.com",
    "storage.googleapis.com",
    "logging.googleapis.com",
    "secretmanager.googleapis.com"
  ]
  project_budget = {
    budget_amount        = 1000
    alert_spent_percents = [0.5, 0.75, 0.9, 0.95]
    alert_pubsub_topic   = null
  }

  labels = {
    environment      = var.env
    env_code         = var.environment_code
    application_name = "secret"
    billing_code     = var.env_billing_code
  }
}