variable "image" { default = "ubuntu-os-cloud/ubuntu-1604-lts" }
variable "machine_type" { default = "n1-standard-1" }
variable "zone" { default = "us-east1-b" }

# List: variable with multiple values
variable "name_count" { default = ["server1", "server2", "server3"] }

resource "google_compute_instance" "default" {
    # count: how many of the resource we're going to make
    # length(list): the length method takes in a list and returns it's size
    count = "${length(var.name_count)}"

    #  change name for each instance (3 in this case)
    name = "list-${count.index+1}"
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

# Add *. before name (after default) for multiple instances
output "name" { value = "${google_compute_instance.default.*.name}" }
output "machine_type" { value = "${google_compute_instance.default.*.machine_type}" }
output "zone" { value = "${google_compute_instance.default.*.zone}" }