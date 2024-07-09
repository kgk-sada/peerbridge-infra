# manuall triggered cloud build for dev env
resource "google_cloudbuild_trigger" "cicd_trigger_dev_tp" {
  name        = "cicd-trigger-dev-tp"
  location = "us-central1"
  project     = module.devops.project_id
  description = "Cloud Build trigger for development environment"
  service_account = module.cloud_build_service_account.service_account.id
  

  trigger_template {
    branch_name = ""
    repo_name   = ""
  }

  build {
    step {
      name = "gcr.io/cloud-builders/gcloud"
      args = ["app", "deploy"]
    }
    # Add more steps as needed
  }
}

# manuall triggered cloud build for staging env
resource "google_cloudbuild_trigger" "cicd_trigger_staging_tp" {
  name        = "cicd-trigger-staging-tp"
  location    = "us-central1"
  project     = module.devops.project_id
  description = "Cloud Build trigger for staging environment"
  service_account = module.cloud_build_service_account.service_account.id

  trigger_template {
    branch_name = ""
    repo_name   = ""
  }

  build {
    step {
      name = "gcr.io/cloud-builders/gcloud"
      args = ["app", "deploy"]
    }
  }

  approval_config {
    approval_required = true
  }
}

# manuall triggered cloud build for training env
resource "google_cloudbuild_trigger" "cicd_trigger_training_tp" {
  name        = "cicd-trigger-training-tp"
  location    = "us-central1"
  project     = module.devops.project_id
  description = "Cloud Build trigger for training environment"
  service_account = module.cloud_build_service_account.service_account.id

  trigger_template {
    branch_name = ""
    repo_name   = ""
  }

  build {
    step {
      name = "gcr.io/cloud-builders/gcloud"
      args = ["app", "deploy"]
    }
  }

  approval_config {
    approval_required = true
  }
}

# manuall triggered cloud build for prod env
resource "google_cloudbuild_trigger" "cicd_trigger_prod_tp" {
  name        = "cicd-trigger-prod-tp"
  location    = "us-central1"
  project     = module.devops.project_id
  description = "Cloud Build trigger for production environment"
  service_account = module.cloud_build_service_account.service_account.id

  trigger_template {
    branch_name = ""
    repo_name   = ""
  }

  build {
    step {
      name = "gcr.io/cloud-builders/gcloud"
      args = ["app", "deploy"]
    }
  }

  approval_config {
    approval_required = true
  }
}
