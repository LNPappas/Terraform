resource "google_compute_firewall" "allow_http" {
    name = "allow-http"
    network = "default"

    allow {
        protocol = "tcp"
        ports = ["80"]
    }

    # name of this resource to reference in main
    target_tags = ["allow-http"]
}

resource "google_compute_firewall" "allow_https" {
    name = "allow-https"
    network = "default"

    allow {
        protocol = "tcp"
        ports = ["443"]
    }

    # name of this resource to reference in main
    target_tags = ["allow-https"]
}