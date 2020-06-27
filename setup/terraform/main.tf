provider "google" {
  version = "3.5.0"

  credentials = file(var.credentials_file)

  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "control" {
  name         = "control"
  machine_type = var.machine_types["control"]
  tags         = ["group1","group2"]
  zone = var.lb-zones["i1"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }

  metadata = {
        startup-script = var.lb-startup
  } 

  allow_stopping_for_update = true
}

#instance 2
resource "google_compute_instance" "worker1" {
  name         = "worker1"
  machine_type = var.machine_types[var.environment]
  tags         = ["group1","group2"]
  zone = var.lb-zones["i2"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }

  metadata = {
        startup-script = var.lb-startup
  } 
}

#instance 3
resource "google_compute_instance" "worker2" {
  name         = "worker2"
  machine_type = var.machine_types[var.environment]
  tags         = ["group1","group2"]
  zone = var.lb-zones["i3"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }

  metadata = {
        startup-script = var.lb-startup
  } 
}

resource "google_compute_firewall" "terra-firewall" {
  name    = "test-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "22"]
  }

}

resource "google_compute_firewall" "kube-firewall" {
  name    = "kube-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["6443"] 
  }

}

# Adding a DNS to set up some records

resource "google_dns_managed_zone" "private-zone" {
  name        = "private-zone"
  dns_name    = "kube.com."
  description = "Private DNS zone"
  visibility = "private"

  private_visibility_config {
    networks {
      network_url = "https://www.googleapis.com/compute/v1/${google_compute_network.vpc_network.id}"
    }
  }
}

# Add the 3 DNS Registries
resource "google_dns_record_set" "control" {
  name         = "control.${google_dns_managed_zone.private-zone.dns_name}"
  managed_zone = google_dns_managed_zone.private-zone.name
  type         = "A"
  ttl          = 300

  rrdatas = [google_compute_instance.control.network_interface[0].network_ip]
}

resource "google_dns_record_set" "worker1" {
  name         = "worker1.${google_dns_managed_zone.private-zone.dns_name}"
  managed_zone = google_dns_managed_zone.private-zone.name
  type         = "A"
  ttl          = 300

  rrdatas = [google_compute_instance.worker1.network_interface[0].network_ip]
}

resource "google_dns_record_set" "worker2" {
  name         = "worker2.${google_dns_managed_zone.private-zone.dns_name}"
  managed_zone = google_dns_managed_zone.private-zone.name
  type         = "A"
  ttl          = 300

  rrdatas = [google_compute_instance.worker2.network_interface[0].network_ip]
}