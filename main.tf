terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {

  //credentials = TF_VAR_GOOGLE_CREDENTIALS

  project = "demotfcloud"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_storage_bucket" "test-bucket" {
  name          = "terraform-cloud-test-bucket"
  location      = "us-central1-c"
  force_destroy = true

  uniform_bucket_level_access = true
}