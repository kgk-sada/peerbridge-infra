variable "region" {
  description = "The GCP region"
  default     = "us-central1"
}

variable "enable_hub_and_spoke" {
  description = "Enable Hub-and-Spoke architecture."
  type        = bool
  default     = false
}

variable "billing_data_users" {
  description = "Google Workspace or Cloud Identity group that have access to billing data set."
  type        = string
}

variable "domains_to_allow" {
  description = "The list of domains to allow users from in IAM. Used by Domain Restricted Sharing Organization Policy. Must include the domain of the organization you are deploying the foundation. To add other domains you must also grant access to these domains to the Terraform Service Account used in the deploy."
  type        = list(string)
}

variable "create_access_context_manager_access_policy" {
  description = "Whether to create access context manager access policy."
  type        = bool
  default     = true
}

variable "scc_notification_filter" {
  description = "Filter used to create the Security Command Center Notification, you can see more details on how to create filters in https://cloud.google.com/security-command-center/docs/how-to-api-filter-notifications#create-filter"
  type        = string
  default     = "state = \"ACTIVE\""
}

variable "enforce_allowed_worker_pools" {
  description = "Whether to enforce the organization policy restriction on allowed worker pools for Cloud Build."
  type        = bool
  default     = false
}

variable "data_access_logs_enabled" {
  description = "Enable Data Access logs of types DATA_READ, DATA_WRITE for all GCP services. Enabling Data Access logs might result in your organization being charged for the additional logs usage. See https://cloud.google.com/logging/docs/audit#data-access The ADMIN_READ logs are enabled by default."
  type        = bool
  default     = false
}

variable "log_export_storage_location" {
  description = "The location of the storage bucket used to export logs."
  type        = string
  default     = "US"
}

variable "billing_export_dataset_location" {
  description = "The location of the dataset for billing data export."
  type        = string
  default     = "US"
}

variable "log_export_storage_force_destroy" {
  description = "(Optional) If set to true, delete all contents when destroying the resource; otherwise, destroying the resource will fail if contents are present."
  type        = bool
  default     = false
}

variable "log_export_storage_versioning" {
  description = "(Optional) Toggles bucket versioning, ability to retain a non-current object version when the live object version gets replaced or deleted."
  type        = bool
  default     = false
}

variable "log_export_storage_retention_policy" {
  description = "Configuration of the bucket's data retention policy for how long objects in the bucket should be retained."
  type = object({
    is_locked             = bool
    retention_period_days = number
  })
  default = null
}

variable "project_budget" {
  description = <<EOT
  Budget configuration for projects.
  budget_amount: The amount to use as the budget.
  alert_spent_percents: A list of percentages of the budget to alert on when threshold is exceeded.
  EOT
  type = object({
    org_secrets_budget_amount             = optional(number)
    org_secrets_alert_spent_percents      = optional(list(number))
    org_billing_logs_budget_amount        = optional(number)
    org_billing_logs_alert_spent_percents = optional(list(number))
    org_audit_logs_budget_amount          = optional(number,)
    org_audit_logs_alert_spent_percents   = optional(list(number))
  })
  default = {}
}

variable "gcp_groups" {
  description = <<EOT
  Groups to grant specific roles in the Organization.
  platform_viewer: Google Workspace or Cloud Identity group that have the ability to view resource information across the Google Cloud organization.
  security_reviewer: Google Workspace or Cloud Identity group that members are part of the security team responsible for reviewing cloud security
  network_viewer: Google Workspace or Cloud Identity group that members are part of the networking team and review network configurations.
  scc_admin: Google Workspace or Cloud Identity group that can administer Security Command Center.
  audit_viewer: Google Workspace or Cloud Identity group that members are part of an audit team and view audit logs in the logging project.
  global_secrets_admin: Google Workspace or Cloud Identity group that members are responsible for putting secrets into Secrets Manage
  EOT
  type = object({
    platform_viewer      = optional(string, null)
    security_reviewer    = optional(string, null)
    network_viewer       = optional(string, null)
    network_admin        = optional(string, null)
    audit_viewer         = optional(string, null)
    global_secrets_admin = optional(string, null)
    monitoring_users     = optional(string, null)
  })
  default = {}
}

variable "gcp_user" {
  description = <<EOT
  Users to grant specific roles in the Organization.
  org_admin: Identity that has organization administrator permissions.
  billing_creator: Identity that can create billing accounts.
  billing_admin: Identity that has billing administrator permissions.
  EOT
  type = object({
    org_admin       = optional(string, null)
    billing_creator = optional(string, null)
    billing_admin   = optional(string, null)
  })
  default = {}
}

variable "essential_contacts_language" {
  description = "Essential Contacts preferred language for notifications, as a ISO 639-1 language code. See [Supported languages](https://cloud.google.com/resource-manager/docs/managing-notification-contacts#supported-languages) for a list of supported languages."
  type        = string
  default     = "en"
}

variable "remote_state_bucket" {
  description = "Backend bucket to load Terraform Remote State Data from previous steps."
  type        = string
}

variable "essential_contacts_domains_to_allow" {
  description = "The list of domains that email addresses added to Essential Contacts can have."
  type        = list(string)
}

variable "create_unique_tag_key" {
  description = "Creates unique organization-wide tag keys by adding a random suffix to each key."
  type        = bool
  default     = false
}

variable "network_admin_roles" {
  description = "List of roles to be assigned to the network_admin group."
  type        = list(string)
}



# OPTIONAL PARAMETERS
variable "storage_class" {
  description = "The Storage Class of the new bucket. Supported values include: STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE."
  default     = "STANDARD"
  type        = string
}

variable "uniform_access" {
  description = "If set to true, all objects in the GCS bucket will have the same access levels (uniform). Set this to 'false' to be able to specify distinct access-levels to individual objects explicitly (fine-grained). Cannot be set to 'false' if 90 days have passed with the 'true' setting.  Considered 'true' if 'var.bucket_name' is a domain name."
  default     = true
  type        = bool
}

variable "enable_versioning" {
  description = "Whether objects in the bucket should be versioneed or not. Considered 'true' if 'var.bucket_name' is a domain name."
  default     = false
  type        = bool
}