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
resource "google_compute_instance" "default" {
    count = "1"
    name = "defaultJoin-${count.index+1}"
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
        
        # this default resource cannot be built until the second is complete
        depends_on = ["google_compute_instance.second"]
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
        
        # this second resource cannot be built until the default is complete
        # depends_on = ["google_compute_instance.default"]
    }
}

output "name" { value = "${google_compute_instance.default.name}" }
output "machine_type" { value = "${google_compute_instance.default.machine_type}" }
output "zone" { value = "${google_compute_instance.default.zone}" }

output "name" { value = "${google_compute_instance.second.name}" }
output "machine_type" { value = "${google_compute_instance.second.machine_type}" }
output "zone" { value = "${google_compute_instance.second.zone}" }