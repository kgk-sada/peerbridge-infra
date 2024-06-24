terraform {
  backend "gcs" {
    bucket = "bkt-prj-b-seed-tfstate-163b" #UPDATE_ME
    prefix = "terraform/environments/development"
  }
}
