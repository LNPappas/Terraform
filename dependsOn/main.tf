variable "image" { default = "ubuntu-os-cloud/ubuntu-1604-lts" }
variable "machine_type" { 
    type = "map"
    default = {
        "dev" = "n1-standard-1"
        "prod" = "n1-standard-2"
    } 
}
variable "zone" { default = "us-east1-b" }

# Use depends when one instance depends on another instance 
# Used for ordering instance deployment
resource "google_compute_instance" "first" {
    count = "1"
    name = "firstJoin-${count.index+1}"
    machine_type = var.machine_type["dev"]
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

resource "google_compute_instance" "second" {
    count = "1"
    name = "secondJoin-${count.index+1}"
    machine_type = var.machine_type["dev"]
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
        depends_on
    }
}

output "name" { value = "${google_compute_instance.default.name}" }
output "machine_type" { value = "${google_compute_instance.default.machine_type}" }
output "zone" { value = "${google_compute_instance.default.zone}" }