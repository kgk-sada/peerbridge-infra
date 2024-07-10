variable "bucket_suffix" {
  description = "Suffix to append to all bucket names"
  default     = "-tp-staging"
}

variable "bucket_names" {
  default = [
    "gcp-webjobs-eventhub",
    "gcp-webjobs-hosts",
    "gcp-webjobs-secrets",
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




resource "google_storage_bucket" "pbtsfilestore" {
  project                     = var.gcp_bucket_project_id
  name                        = "pbtsfilestore${var.bucket_suffix}"
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
  bucket = google_storage_bucket.pbtsfilestore.name
  content = " "
  count  = 1
}

resource "google_storage_bucket_object" "pb_cor_log_files" {
  name   = "PBCorLogFiles/"
  bucket = google_storage_bucket.pbtsfilestore.name
  content = " "
  count  = 1
}
resource "google_storage_bucket_object" "core_mobile_app" {
  name   = "ClientApps/Core Mobile App/"
  bucket = google_storage_bucket.pbtsfilestore.name
  content = " "
  count  = 1
}

resource "google_storage_bucket_object" "firmware" {
  name   = "ClientApps/Firmware/"
  bucket = google_storage_bucket.pbtsfilestore.name
  content = " "
  count  = 1
}

resource "google_storage_bucket_object" "development" {
  name   = "ClientApps/Core Mobile App/Development/"
  bucket = google_storage_bucket.pbtsfilestore.name
  content = " "
  count  = 1
}

resource "google_storage_bucket_object" "production" {
  name   = "ClientApps/Core Mobile App/Production/"
  bucket = google_storage_bucket.pbtsfilestore.name
  content = " "
  count  = 1
}


resource "google_storage_bucket" "insert-Log" {
  project                     = var.gcp_bucket_project_id
  name                        = "insertlog${var.bucket_suffix}"
  location                    = "us-central1"
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_access
  force_destroy               = false
  versioning {
    enabled = var.enable_versioning
  }
  lifecycle_rule {
    action {
      type          = "SetStorageClass"
      storage_class = "COLDLINE"
    }
    condition {
      age = 90
    }
  }
}