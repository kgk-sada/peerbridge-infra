module "project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 14.0"

  random_project_id           = true
  random_project_id_length    = 4
  name                        = "${var.project_prefix}-${var.environment_code}-${var.application_name}-tp"
  org_id                      = var.org_id
  billing_account             = var.billing_account
  folder_id                   = var.folder_id
  disable_services_on_destroy = false
  activate_apis               = var.activate_apis
  enable_shared_vpc_host_project = var.enable_shared_vpc_host_project


  labels = var.labels

  budget_alert_pubsub_topic   = var.project_budget.alert_pubsub_topic
  budget_alert_spent_percents = var.project_budget.alert_spent_percents
  budget_amount               = var.project_budget.budget_amount
}