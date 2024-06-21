locals {
  network_project_id     = data.terraform_remote_state.env.outputs.network_project_id
  application_project_id = data.terraform_remote_state.env.outputs.application_project_id    
  network_self_link      = data.terraform_remote_state.network.outputs.prod_network_self_link
  subnet_name            = data.terraform_remote_state.network.outputs.prod_subnetwork_name_01
  master_auth_subnetwork = data.terraform_remote_state.network.outputs.prod_subnetwork_name_01
  pods_range_name        = data.terraform_remote_state.network.outputs.prod_subnets_secondary_ip_range[0][0].range_name
  svc_range_name         = data.terraform_remote_state.network.outputs.prod_subnets_secondary_ip_range[0][1].range_name
}


data "terraform_remote_state" "env" {
  backend = "gcs"

  config = {
    bucket = var.remote_state_bucket
    prefix = "terraform/environments/prod"
  }
}

data "terraform_remote_state" "network" {
  backend = "gcs"

  config = {
    bucket = var.remote_state_bucket
    prefix = "terraform/networks/prod"
  }
}