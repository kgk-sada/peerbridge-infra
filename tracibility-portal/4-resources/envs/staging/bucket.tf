resource "google_storage_bucket" "gcs_bucket" {
  project                     = var.gcp_bucket_project_id
  name                        = var.bucket_name
  location                    = "us-central1"
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_access
  force_destroy               = false
  versioning {
    enabled = var.enable_versioning
  }
}