# configuring Terraform to use Google Cloud Storage (GCS) for remote state storage
terraform {
  backend "gcs" {
    bucket = "bkt-prj-b-seed-tfstate-163b"
    prefix = "terraform/bootstrap/state"
  }
}