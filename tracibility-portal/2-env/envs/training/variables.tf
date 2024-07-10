variable "monitoring_workspace_users" {
  description = "Google Workspace or Cloud Identity group that have access to Monitoring Workspaces."
  type        = string
}

variable "remote_state_bucket" {
  description = "Backend bucket to load Terraform Remote State Data from previous steps."
  type        = string
}

variable "env" {
  description = "The environment to prepare (ex. development)"
  type        = string
}

variable "environment_code" {
  type        = string
  description = "A short form of the folder level resources (environment) within the Google Cloud organization (ex. d)."
}

variable "sub_folder" {
  type        = list(string)
  description = "The list of sub folders to create"
}

variable "env_billing_code" {
  type        = string
  description = "The billing code for environment"
}

variable "iam_roles_group_pb_tp_training_group" {
  description = "A map of roles to members"
  type        = set(string)
}