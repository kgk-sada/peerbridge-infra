terraform {
  backend "gcs" {
    bucket = "bkt-prj-b-seed-tfstate-76d3"
    prefix = "terraform/networks/training"
  }
}