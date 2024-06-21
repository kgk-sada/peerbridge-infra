terraform {
  backend "gcs" {
    bucket = "bkt-prj-b-seed-tfstate-76d3" #UPDATE_ME
    prefix = "terraform/resources/training"
  }
}
