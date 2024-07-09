terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.79"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.79"
    }
  }
  required_version = ">= 0.13"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "google" {
  project     = local.application_project_id
  region = "us-central1"
}

provider "google-beta" {
  project     = local.application_project_id
  region = "us-central1"
}