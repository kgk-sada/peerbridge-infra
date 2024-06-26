locals {
  network_project_id     = data.terraform_remote_state.env.outputs.network_project_id
  application_project_id = data.terraform_remote_state.env.outputs.application_project_id    
  network_self_link      = data.terraform_remote_state.network.outputs.dev_network_self_link
  subnet_name            = data.terraform_remote_state.network.outputs.dev_subnetwork_name_01
  master_auth_subnetwork = data.terraform_remote_state.network.outputs.dev_subnetwork_name_01
  subnet_01_self_link    = data.terraform_remote_state.network.outputs.dev_subnetwork_self_links[0]
  subnet_02_self_link    = data.terraform_remote_state.network.outputs.dev_subnetwork_self_links[1]
  primary_range_name        = data.terraform_remote_state.network.outputs.dev_subnets_secondary_ip_range[0][0].range_name
  secondary_range_name         = data.terraform_remote_state.network.outputs.dev_subnets_secondary_ip_range[0][1].range_name
}

data "terraform_remote_state" "env" {
  backend = "gcs"

  config = {
    bucket = var.remote_state_bucket
    prefix = "terraform/environments/development"
  }
}

data "terraform_remote_state" "network" {
  backend = "gcs"

  config = {
    bucket = var.remote_state_bucket
    prefix = "terraform/networks/development"
  }
}

data "google_compute_network" "network" {
  name = var.network_name
  project = local.network_project_id
}

