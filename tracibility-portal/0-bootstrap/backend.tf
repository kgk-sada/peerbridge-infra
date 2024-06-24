terraform {
  backend "gcs" {
    bucket = "bkt-prj-b-seed-tfstate-163b"
    prefix = "terraform/bootstrap/state"
  }
}

### NEED to be updated after the first a