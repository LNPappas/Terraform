variable "image" { default = "ubuntu-os-cloud/ubuntu-1604-lts" }
variable "machine_type" { default = "n1-standard-1" }
variable "zone" { default = "us-east1-b" }

resource "google_compute_instance" "default" {
    name = "outputs"
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

output "name" { value = "${google_compute_instance.default.name}" }
output "machine_type" { value = "${google_compute_instance.default.machine_type}" }
output "zone" { value = "${google_compute_instance.default.zone}" }
