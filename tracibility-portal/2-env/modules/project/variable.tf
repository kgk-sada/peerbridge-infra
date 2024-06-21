variable "folder_id" {
  description = "The id of subfolder"
  type        = string
}

variable "application_name" {
  description = "The name of parent application"
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

variable "org_id" {

}

variable "project_prefix" {

}

variable "billing_account" {

}
# variable "remote_state_bucket" {
#   description = "Backend bucket to load Terraform Remote State Data from previous steps."
#   type        = string
# }

# variable "monitoring_workspace_users" {
#   description = "Google Workspace or Cloud Identity group that have access to Monitoring Workspaces."
#   type        = string
# }

# variable "project_budget" {
#   description = <<EOT
#   Budget configuration for projects.
#   budget_amount: The amount to use as the budget.
#   alert_spent_percents: A list of percentages of the budget to alert on when threshold is exceeded.
#   alert_pubsub_topic: The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}`.
#   EOT
#   type = object({
#     application_budget_amount        = optional(number, 1000)
#     application_alert_spent_percents = optional(list(number), [0.5, 0.75, 0.9, 0.95])
#     application_alert_pubsub_topic   = optional(string, null)
#     monitoring_budget_amount         = optional(number, 1000)
#     monitoring_alert_spent_percents  = optional(list(number), [0.5, 0.75, 0.9, 0.95])
#     monitoring_alert_pubsub_topic    = optional(string, null)
#     secret_budget_amount             = optional(number, 1000)
#     secret_alert_spent_percents      = optional(list(number), [0.5, 0.75, 0.9, 0.95])
#     secret_alert_pubsub_topic        = optional(string, null)
#   })
#   default = {}
# }

variable "project_budget" {
  description = <<EOT
  Budget configuration for projects.
  budget_amount: The amount to use as the budget.
  alert_spent_percents: A list of percentages of the budget to alert on when threshold is exceeded.
  alert_pubsub_topic: The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}`.
  EOT
  type = object({
    budget_amount        = optional(number, 1000)
    alert_spent_percents = optional(list(number), [0.5, 0.75, 0.9, 0.95])
    alert_pubsub_topic   = optional(string, null)
  })
  default = {}
}

variable "activate_apis" {
  type        = list(string)
  description = "The list of APIs need to be activated"
}

variable "labels" {
  type        = map(string)
  description = "Label values to be attached to project"
}

variable "enable_shared_vpc_host_project" {
  description = "If this project is a shared VPC host project. If true, you must *not* set svpc_host_project_id variable. Default is false."
  type        = bool
  default     = false
}
