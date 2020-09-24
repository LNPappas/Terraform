resource "google_compute_instance" "default" {
    name = "first"
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

# set path for terraform folder (in this case /opt ): export PATH=$PATH:/opt

# terraform init instanceName/
# terraform plan instanceName/
# terraform apply instanceName/
# terraform destroy instanceName/

# for scripts: first make executable with chmod u+x name.sh for each
#  then run sequentially 
# ./plan name/
# ./apply name/
# ./destroy name/