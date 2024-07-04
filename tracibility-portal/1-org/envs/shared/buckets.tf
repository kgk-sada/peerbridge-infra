variable "bucket_suffix" {
  description = "Suffix to append to all bucket names"
  default     = "-tp-dev"
}

resource "google_storage_bucket" "cicd-bucket" {
  project                     = module.devops.project_id
  name                        = "cicd-${var.bucket_suffix}"
  location                    = "us-central1"
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_access
  force_destroy               = false
  versioning {
    enabled = var.enable_versioning
  }
}


resource "google_storage_bucket_object" "cicd-bucket-zipfile" {
  name   = "ZipFile/"
  bucket = google_storage_bucket.cicd-bucket.name
  content = " "
  count  = 1
}

resource "google_storage_bucket_object" "cicd-bucket-script" {
  name   = "Script/"
  bucket = google_storage_bucket.cicd-bucket.name
  content = " "
  count  = 1
}