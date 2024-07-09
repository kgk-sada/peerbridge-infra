# resource creates a Google Cloud Storage bucket for CICD with specified settings
###### dev
resource "google_storage_bucket" "cicd-bucket" {
  project                     = module.devops.project_id
  name                        = "cicd-tp-dev"
  location                    = "us-central1"
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_access
  force_destroy               = false
  versioning {
    enabled = var.enable_versioning
  }
}

# resource creates an empty zip file object in the CICD bucket
resource "google_storage_bucket_object" "cicd-bucket-zipfile" {
  name   = "ZipFile/"
  bucket = google_storage_bucket.cicd-bucket.name
  content = " "
  count  = 1
}

# resource creates an empty script file object in the CICD bucket
resource "google_storage_bucket_object" "cicd-bucket-script" {
  name   = "Script/"
  bucket = google_storage_bucket.cicd-bucket.name
  content = " "
  count  = 1
}

# resource creates an empty Static script file object in the CICD bucket
resource "google_storage_bucket_object" "cicd-bucket-statick-script" {
  name   = "Static-Script/"
  bucket = google_storage_bucket.cicd-bucket.name
  content = " "
  count  = 1
}

resource "google_storage_bucket_object" "static-script" {
  name   = "Static-Script/pbts.startup.script-v2.ps1"
  bucket = google_storage_bucket.cicd-bucket.name
  source = "./pbts.startup.script-v2.ps1"  # local file path

}

#### stg

# resource creates a Google Cloud Storage bucket for CICD with specified settings
resource "google_storage_bucket" "cicd-bucket-stg" {
  project                     = module.devops.project_id
  name                        = "cicd-tp-stg"
  location                    = "us-central1"
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_access
  force_destroy               = false
  versioning {
    enabled = var.enable_versioning
  }
}

# resource creates an empty zip file object in the CICD bucket
resource "google_storage_bucket_object" "cicd-bucket-zipfile-stg" {
  name   = "ZipFile/"
  bucket = google_storage_bucket.cicd-bucket-stg.name
  content = " "
  count  = 1
}

# resource creates an empty script file object in the CICD bucket
resource "google_storage_bucket_object" "cicd-bucket-script-stg" {
  name   = "Script/"
  bucket = google_storage_bucket.cicd-bucket-stg.name
  content = " "
  count  = 1
}

# resource creates an empty Static script file object in the CICD bucket
resource "google_storage_bucket_object" "cicd-bucket-statick-script-stg" {
  name   = "Static-Script/"
  bucket = google_storage_bucket.cicd-bucket-stg.name
  content = " "
  count  = 1
}

resource "google_storage_bucket_object" "static-script-stg" {
  name   = "Static-Script/pbts.startup.script-v2.ps1"
  bucket = google_storage_bucket.cicd-bucket-stg.name
  source = "./pbts.startup.script-v2.ps1"  # local file path

}


##### training

# resource creates a Google Cloud Storage bucket for CICD with specified settings
resource "google_storage_bucket" "cicd-bucket-training" {
  project                     = module.devops.project_id
  name                        = "cicd-tp-training"
  location                    = "us-central1"
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_access
  force_destroy               = false
  versioning {
    enabled = var.enable_versioning
  }
}

# resource creates an empty zip file object in the CICD bucket
resource "google_storage_bucket_object" "cicd-bucket-zipfile-training" {
  name   = "ZipFile/"
  bucket = google_storage_bucket.cicd-bucket-training.name
  content = " "
  count  = 1
}

# resource creates an empty script file object in the CICD bucket
resource "google_storage_bucket_object" "cicd-bucket-script-training" {
  name   = "Script/"
  bucket = google_storage_bucket.cicd-bucket-training.name
  content = " "
  count  = 1
}

# resource creates an empty Static script file object in the CICD bucket
resource "google_storage_bucket_object" "cicd-bucket-statick-script-training" {
  name   = "Static-Script/"
  bucket = google_storage_bucket.cicd-bucket-training.name
  content = " "
  count  = 1
}

resource "google_storage_bucket_object" "static-script-training" {
  name   = "Static-Script/pbts.startup.script-v2.ps1"
  bucket = google_storage_bucket.cicd-bucket-training.name
  source = "./pbts.startup.script-v2.ps1"  # local file path

}


##### prod

# resource creates a Google Cloud Storage bucket for CICD with specified settings
resource "google_storage_bucket" "cicd-bucket-prod" {
  project                     = module.devops.project_id
  name                        = "cicd-tp-prod"
  location                    = "us-central1"
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_access
  force_destroy               = false
  versioning {
    enabled = var.enable_versioning
  }
}

# resource creates an empty zip file object in the CICD bucket
resource "google_storage_bucket_object" "cicd-bucket-zipfile-prod" {
  name   = "ZipFile/"
  bucket = google_storage_bucket.cicd-bucket-prod.name
  content = " "
  count  = 1
}

# resource creates an empty script file object in the CICD bucket
resource "google_storage_bucket_object" "cicd-bucket-script-prod" {
  name   = "Script/"
  bucket = google_storage_bucket.cicd-bucket-prod.name
  content = " "
  count  = 1
}

# resource creates an empty Static script file object in the CICD bucket
resource "google_storage_bucket_object" "cicd-bucket-statick-script-prod" {
  name   = "Static-Script/"
  bucket = google_storage_bucket.cicd-bucket-prod.name
  content = " "
  count  = 1
}

resource "google_storage_bucket_object" "static-script-prod" {
  name   = "Static-Script/pbts.startup.script-v2.ps1"
  bucket = google_storage_bucket.cicd-bucket-prod.name
  source = "./pbts.startup.script-v2.ps1"  # local file path

}
