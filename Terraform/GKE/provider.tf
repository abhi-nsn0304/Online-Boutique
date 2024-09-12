terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }

  backend "gcs" {
    bucket = "terraform-state-bucket12"  # Replace with your bucket name
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}