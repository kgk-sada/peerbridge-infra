locals {
  parent_resource_id   = local.parent_folder != "" ? local.parent_folder : local.org_id
  parent_resource_type = local.parent_folder != "" ? "folder" : "organization"
  parent_resources     = { resource = local.parent_resource_id }
  all_logs_filter      = ""
}

resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}

module "logs_export" {
  source = "../../modules/centralized-logging"

  resources                      = local.parent_resources
  resource_type                  = local.parent_resource_type
  logging_destination_project_id = module.org_audit_logs.project_id


#  Send logs to Storage

  storage_options = {
    logging_sink_filter          = local.all_logs_filter
    logging_sink_name            = "sk-c-logging-bkt"
    storage_bucket_name          = "bkt-${module.org_audit_logs.project_id}-org-logs-${random_string.suffix.result}"
    location                     = var.log_export_storage_location
    retention_policy_enabled     = var.log_export_storage_retention_policy != null
    retention_policy_is_locked   = var.log_export_storage_retention_policy == null ? null : var.log_export_storage_retention_policy.is_locked
    retention_policy_period_days = var.log_export_storage_retention_policy == null ? null : var.log_export_storage_retention_policy.retention_period_days
    force_destroy                = var.log_export_storage_force_destroy
    versioning                   = var.log_export_storage_versioning
  }


#  Send logs to Logbucket

  logbucket_options = {
    logging_sink_name   = "sk-c-logging-logbkt"
    logging_sink_filter = local.all_logs_filter
    name                = "logbkt-org-logs-${random_string.suffix.result}"
    location            = local.default_region
  }
}