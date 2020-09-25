variable "path" { default = "/home/udemy/terraform/credentials"}

provider "google" {
    project = "udemy-288022"
    region = "us-east1"
    credentials = "${file("${var.path}/secrets.json")}"
}

provider "google-beta" {
    project = "udemy-288022"
    region = "us-east1"
    credentials = "${file("${var.path}/secrets.json")}"
}