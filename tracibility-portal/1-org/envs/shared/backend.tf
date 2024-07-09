# configures Terraform to use Google Cloud Storage (GCS) for remote state storage with a specified bucket and prefix
terraform {
  backend "gcs" {
    bucket = "bkt-prj-b-seed-tfstate-163b" # <--- CHANGE THIS
    prefix = "terraform/org/state"
  }
}
