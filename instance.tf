

resource "google_compute_instance" "private-vm" {
  name         = "nagy-private-vm"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  tags         = ["nagy-vm"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.Management-Subnet.self_link
  }
  service_account {
    email  = google_service_account.gke-admin.email
    scopes = ["cloud-platform"]
  }
}