variable "remote_state_bucket" {
  type        = string
  description = "The Value of Bucket to read information"
}

variable "default_region" {
  type        = string
  description = "Default Region for Network deployment"
}

variable "environment_code" {
  type        = string
  description = "The code for specific environment"
}