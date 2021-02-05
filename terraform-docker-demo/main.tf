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

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
  cors {
    origin          = ["http://image-store.com"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}