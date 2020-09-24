variable "image" { default = "ubuntu-os-cloud/ubuntu-1604-lts" }
variable "zone" { default = "us-east1-b" }
variable "environment" { default = "production" }
variable "machine_type_dev" { default = "n1-standard-1"}
variable "machine_type" { default = { "n1-standard-2" }

resource "google_compute_instance" "default" {
    count = "1"
    name = "conditional-${count.index+1}"

    # conditional based of environment variable
    # condition ? do this : otherwise do this
    machine_type = "${var.environment == "production" ? var.machine_type : var.machine_type_dev}"
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