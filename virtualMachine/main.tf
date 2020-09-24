variable "image" { default = "ubuntu-os-cloud/ubuntu-1604-lts" }
variable "machine_type" { default = "n1-standard-1" }
variable "zone" { default = "us-east1-b" }
variable "machine_count" { default = "1"}

resource "google_compute_instance" "default" {
    count = var.machine_count
    name = "vm"
    machine_type = var.machine_type
    zone = var.zone

    # forwarding ips
    can_ip_forward = "false"

    # good to decribe instances for working env
    description = "This is our Virtual Machine"

    # tags for firewall (in firewall rules)
    # target-tag from firewall.tf
    tags = ["allow-http", "allow-https"]

    boot_disk {
        initialize_params {
            image = var.image

            # set size of boot (in gbs)
            size = "20" 
        }
    }

    # key:value pairs, etc
    labels = {
        name = "list-${count.index+1}"
        machine_type = var.machine_type
    }

    network_interface {
        network = "default"
    }

    # for startup scripts, etc...
    metadata = {
        size = "20"
        foo = "bar"
    }

    # would put a path here (don't have one in this case)
    metadata_startup_script = "echo hi"

    service_account {
        scopes = ["userinfo-email", "compute-ro", "storage-ro"]
    }
}