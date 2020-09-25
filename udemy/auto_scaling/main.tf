# Instance Template (describes instance)
resource "google_compute_instance_template" "instance_template" {
    count = 1
    name = "udemy-server-${count.index+1}"
    description = "autoscaling instance"
    # tags = [] # for networking 
    labels = {
        environment = "production"
        name = "udemy-server-${count.index+1}"
    }
    instance_description = "instance to be autoscaling"
    machine_type = "n1-standard-1"
    can_ip_forward = "false"

    network_interface {
        network = "default"
    }

    scheduling {
        automatic_restart = true
        on_host_maintenance = "MIGRATE"
    }
    
    disk {
        source_image = "ubuntu-os-cloud/ubuntu-1604-lts"
        auto_delete = true
        boot = true
    }

    disk {
        auto_delete = false
        disk_size_gb = 10
        mode = "READ_WRITE"
        type = "PERSISTENT"
    }
    metadata = {
        foo = "bar"
    }

    service_account {
        scopes = ["userinfo-email", "compute-ro", "storage-ro"]
    }
}

# Health Check (when to scale)
resource "google_compute_health_check" "health" {
    count = 1
    name = "udemy"
    check_interval_sec = 5
    timeout_sec = 5
    healthy_threshold = 2
    unhealthy_threshold = 10

    http_health_check {
        request_path = "/alive.jsp"
        port = "8080"
    }
}

# Group Manager (manages instances)
resource "google_compute_region_instance_group_manager" "instance_group_manager" {
    name = "instance-group-manager"
    instance_template = google_compute_instance_template.instance_template[0].self_link
    base_instance_name = "instance-group-manager"
    region = "us-east1"

    auto_healing_policies {
        initial_delay_sec = 1
        health_check = google_compute_health_check.health[0].self_link
    }
}

# Auto Scale Policy (min/max instances)
resource "google_compute_region_autoscaler" "autoscaler" {
    count = 1
    name = "autoscaler"
    project = var.project
    region = var.region
    target = google_compute_region_instance_group_manager.instance_group_manager.self_link

    autoscaling_policy {
        max_replicas = 2
        min_replicas = 1
        cooldown_perion = 60
        cpu_utilization = "0.8"
    }
}