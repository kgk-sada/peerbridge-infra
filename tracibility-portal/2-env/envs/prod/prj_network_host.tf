module "network_host" {
  source = "../../modules/project"

  env              = var.env
  environment_code = var.environment_code
  application_name = "network-host"
  project_prefix   = local.project_prefix
  org_id           = local.org_id
  billing_account  = local.billing_account
  folder_id        = google_folder.env.id

  enable_shared_vpc_host_project = true
  activate_apis = [
    "compute.googleapis.com",
    "serviceusage.googleapis.com",
    "storage.googleapis.com",
    "billingbudgets.googleapis.com",
    "servicenetworking.googleapis.com",
    "container.googleapis.com",
  ]

  labels = {
    environment  = var.env
    env_code     = var.environment_code
    billing_code = var.env_billing_code
  }
}