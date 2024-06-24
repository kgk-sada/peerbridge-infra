
variable "remote_state_bucket" {
  type        = string
  description = "The Value of Bucket to read information"
}

variable "default_region" {
  type        = string
  description = "Default Region for Network deployment"
  default     = "us-central1"
}

variable "environment_code" {
  type        = string
  description = "The code for specific environment"
  default = "d"
}

variable "instance_name" {
  description = "Cloud SQL Instance Name"
}

variable "network_name" {
  description = "Shared VPC Host Network Name"
  default     = "vpc-d-backend"
}

variable "subnetwork_name" {
  description = "Shared VPC Host Subnetwork Name"
  default     = "sb-d-backend-01"
}


##########  private Autopilot cluster specific variables #############

variable "gcp_bucket_project_id" {
  description = "Project in which GCS Bucket Resources will be created."
  type        = string
}

variable "bucket_name" {
  description = "A universally unique name for the bucket. Considered a 'domain name' if the value contains one (or more) period/dot [.]."
  type        = string
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


