provider "google" {
  project = "${var.gcp_project_id}"
  region  = "europe-west1"
  zone    = "europe-west1-b"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "g1-small"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1604-lts"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }

  metadata = {
    sshKeys = "${var.gcp_user}:${tls_private_key.ssh-key.public_key_openssh}"
  }

  connection {
    type = "ssh"
    host = self.network_interface.0.access_config.0.nat_ip
    user = "${var.gcp_user}"
    private_key = "${tls_private_key.ssh-key.private_key_pem}"
  }

  provisioner "remote-exec" {
    inline = [
      "git clone -b ${var.branch} https://github.com/BaptistG/docker-dumb-app.git",
      "cd docker-dumb-app/",
      "sh setup.sh",
    ]
  }
}

resource "tls_private_key" "ssh-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["3000", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
}