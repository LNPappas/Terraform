terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.55.0"
    }
  }
}

provider "google" {
  project = "demotfcloud"
  region  = "us-central1"

}

# resource "google_storage_bucket" "gcs_bucket" {
#   name = "1st-test-bucket-terraform-cloud-pipeline"
# }

# resource "google_storage_bucket" "gcs_bucket_2" {
#   name = "2nd-test-bucket-terraform-cloud-pipeline"
# }