terraform {
  backend "gcs" {
    bucket = "bkt-prj-b-seed-tfstate-163b"
    prefix = "terraform/networks/staging"
  }
}