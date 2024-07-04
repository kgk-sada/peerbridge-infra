variable "bucket_suffix" {
  description = "Suffix to append to all bucket names"
  default     = "-tp-dev"
}

variable "bucket_names" {
  default = [
    "azure-webjobs-eventhub",
    "azure-webjobs-hosts",
    "azure-webjobs-secrets",
    "cor-config",
    "error",
    "mobile-event-clinical-data",
    "ncmr",
    "reps-event-sync",
    "rps-lead-off-index",
    "rps-wearable-event-database",
    "rps-wusb-upload-logs",
    "rps-wusb-validation",
    "trimmed-file"
  ]
}



resource "google_storage_bucket" "buckets" {
  project                     = var.gcp_bucket_project_id
  count  = length(var.bucket_names)
  name   = "${var.bucket_names[count.index]}${var.bucket_suffix}"
  location                    = "us-central1"
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_access
  force_destroy               = false
  versioning {
    enabled = var.enable_versioning
  }
  lifecycle {
    prevent_destroy = true
  }
}




resource "google_storage_bucket" "pbtsfilestore008" {
  project                     = var.gcp_bucket_project_id
  name                        = "pbtsfilestore008${var.bucket_suffix}"
  location                    = "us-central1"
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_access
  force_destroy               = false
  versioning {
    enabled = var.enable_versioning
  }
  lifecycle {
    prevent_destroy = true
  }

}
# Create folders inside the bucket
resource "google_storage_bucket_object" "client_apps" {
  name   = "ClientApps/"
  bucket = google_storage_bucket.pbtsfilestore008.name
  content = " "
  count  = 1
}

resource "google_storage_bucket_object" "pb_cor_log_files" {
  name   = "PBCorLogFiles/"
  bucket = google_storage_bucket.pbtsfilestore008.name
  content = " "
  count  = 1
}
resource "google_storage_bucket_object" "core_mobile_app" {
  name   = "ClientApps/Core Mobile App/"
  bucket = google_storage_bucket.pbtsfilestore008.name
  content = " "
  count  = 1
}

resource "google_storage_bucket_object" "firmware" {
  name   = "ClientApps/Firmware/"
  bucket = google_storage_bucket.pbtsfilestore008.name
  content = " "
  count  = 1
}

resource "google_storage_bucket_object" "development" {
  name   = "ClientApps/Core Mobile App/Development/"
  bucket = google_storage_bucket.pbtsfilestore008.name
  content = " "
  count  = 1
}

resource "google_storage_bucket_object" "production" {
  name   = "ClientApps/Core Mobile App/Production/"
  bucket = google_storage_bucket.pbtsfilestore008.name
  content = " "
  count  = 1
}




resource "google_storage_bucket" "cicd-bucket" {
  project                     = var.gcp_bucket_project_id
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