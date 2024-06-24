locals {
  org_id          = data.terraform_remote_state.bootstrap.outputs.common_config.org_id
  parent_folder   = data.terraform_remote_state.bootstrap.outputs.common_config.parent_folder
  parent          = data.terraform_remote_state.bootstrap.outputs.common_config.parent_id
  billing_account = data.terraform_remote_state.bootstrap.outputs.common_config.billing_account
  default_region  = data.terraform_remote_state.bootstrap.outputs.common_config.default_region
  project_prefix  = data.terraform_remote_state.bootstrap.outputs.common_config.project_prefix
  folder_prefix   = data.terraform_remote_state.bootstrap.outputs.common_config.folder_prefix
  # group_billing_admins                          = data.terraform_remote_state.bootstrap.outputs.group_billing_admins
  # group_org_admins                              = data.terraform_remote_state.bootstrap.outputs.group_org_admins
  # networks_step_terraform_service_account_email = data.terraform_remote_state.bootstrap.outputs.networks_step_terraform_service_account_email
  # bootstrap_folder_name                         = data.terraform_remote_state.bootstrap.outputs.common_config.bootstrap_folder_name
  # c4_project_id                                 = data.terraform_remote_state.env.outputs.prj_d_app_c4
  # smcs_project_id                               = data.terraform_remote_state.env.outputs.prj_d_app_smcs
  network_project_id     = data.terraform_remote_state.env.outputs.network_project_id
  application_project_id = data.terraform_remote_state.env.outputs.application_project_id
}

data "terraform_remote_state" "bootstrap" {
  backend = "gcs"

  config = {
    bucket = var.remote_state_bucket
    prefix = "terraform/bootstrap/state"
  }
}

data "terraform_remote_state" "env" {
  backend = "gcs"

  config = {
    bucket = var.remote_state_bucket
    prefix = "terraform/environments/development"
  }
}


