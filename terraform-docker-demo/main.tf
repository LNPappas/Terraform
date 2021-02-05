terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {

  credentials = env.GOOGLE_CREDENTIALS

  project = env.PROJECT_ID
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_storage_bucket" "test-bucket" {
  name          = "terraform-cloud-test-bucket"
  location      = "us-central1-c"
  force_destroy = true

  uniform_bucket_level_access = true
}