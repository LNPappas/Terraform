variable "image" { default = "ubuntu-os-cloud/ubuntu-1604-lts" }

# Map: Can map multiple key:value pairs to variables 
variable "machine_type" { 
    type = "map"
    default = {
        "dev" = "n1-standard-1"
        "prod" = "n1-standard-2"
    } 
}

variable "zone" { default = "us-east1-b" }
variable "name_count" { default = ["server1", "server2", "server3"] }

resource "google_compute_instance" "default" {
    count = "${length(var.name_count)}"
    name = "maps-${count.index+1}"

    # specify machine type (there are multiple now)
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

output "name" { value = "${google_compute_instance.default.*.name}" }
output "machine_type" { value = "${google_compute_instance.default.*.machine_type}" }
output "zone" { value = "${google_compute_instance.default.*.zone}" }