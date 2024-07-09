locals {
  org_id          = data.terraform_remote_state.bootstrap.outputs.common_config.org_id
  parent          = data.terraform_remote_state.bootstrap.outputs.common_config.parent_id
  billing_account = data.terraform_remote_state.bootstrap.outputs.common_config.billing_account
  project_prefix  = data.terraform_remote_state.bootstrap.outputs.common_config.project_prefix
  folder_prefix   = data.terraform_remote_state.bootstrap.outputs.common_config.folder_prefix
  devops_sa       = data.terraform_remote_state.org.outputs.cloud_build_service_account

}

data "terraform_remote_state" "bootstrap" {
  backend = "gcs"

  config = {
    bucket = var.remote_state_bucket
    prefix = "terraform/bootstrap/state"
  }
}
