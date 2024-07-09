# configures the Google Beta provider with user project override and billing project settings
provider "google-beta" {
  user_project_override = true
  billing_project       = var.groups.billing_project
}

provider "google" {
  user_project_override = true
  billing_project       = var.groups.billing_project
}