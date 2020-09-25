variable "bucket_name" { default = "bucket-1-udemy-terraform" }
variable "location" { default = "us-east1" }
variable "storage_class" { default = "REGIONAL" }

resource "google_storage_bucket" "bucket" {
    count = "1"
    name = var.bucket_name
    location = var.location
    storage_class = var.storage_class

    labels = {
        name = var.bucket_name
        location = var.location
    }

    versioning {
        enabled = true
    }
}