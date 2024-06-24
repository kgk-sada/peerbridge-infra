terraform {
  backend "gcs" {
    bucket = "bkt-prj-b-seed-tfstate-163b" # <--- CHANGE THIS
    prefix = "terraform/org/state"
  }
}
