resource "google_artifact_registry_repository" "clinical_portal_repository" {
  location      = "us-central1"
  repository_id = "clinical-portal"
  description   = "Clinical Portal Repository"
  format        = "DOCKER"
  project = module.devops.project_id
}
