terraform {
  backend "gcs" {
    bucket = "bkt-prj-b-seed-tfstate-76d3" # <--- CHANGE THIS
    prefix = "terraform/org/state"
  }
}
