variable "image" { default = "ubuntu-os-cloud/ubuntu-1604-lts" }
variable "machine_type" { default = "n1-standard-1" }
variable "zone" { default = "us-east1-b" }

variable "name1" { default = "name1" }
variable "name2" { default = "name2" }
variable "name3" { default = "name3" }

# instead of this in resource:
# name = "${var.name1}-${var.name3}-${var.name3}"
# create local variable to call in resource
locals {
    name = "${var.name1}-${var.name3}-${var.name3}"
}

resource "google_compute_instance" "default" {
    # name = "${var.name1}-${var.name3}-${var.name3}"
    name = local.name
    machine_type = var.machine_type
    zone = var.zone

    boot_disk {
        initialize_params {
            image = var.image
        }
    }

    network_interface {
        network = "default"
    }

    service_account {
        scopes = ["userinfo-email", "compute-ro", "storage-ro"]
    }
}

output "name" { value = google_compute_instance.default.name }
