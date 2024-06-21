terraform {
  backend "gcs" {
    bucket = "bkt-prj-b-seed-tfstate-76d3"
    prefix = "terraform/bootstrap/state"
  }
}

### NEED to be updated after the first apply 