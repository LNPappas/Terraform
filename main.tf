# terraform {
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = "3.5.0"
#     }
#   }
# }

# provider "google" {
#   project = "demotfcloud"
#   region  = "us-central1"
#   zone    = "us-central1-c"
# }

resource "google_storage_bucket" "gcs_bucket" {
  name = "test-bucket-random-001123456719"
}