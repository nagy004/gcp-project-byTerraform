

# --------------Cluster-Resource--------------------------
resource "google_container_cluster" "MYGKE" {
  name               = "nagy-cluster"
  location           = "us-central1-c"
  initial_node_count = "1"
  remove_default_node_pool = true
  ip_allocation_policy {
    
  }
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = google_compute_subnetwork.Management-Subnet.ip_cidr_range
    }
  }
  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "192.168.1.0/28"
  }

  network = google_compute_network.vpc_network.self_link
  subnetwork = google_compute_subnetwork.Restricted-Subnet.self_link
  addons_config {
    http_load_balancing {
      disabled = true
    }
  }
}

#-------------- Node-pool ---------------------------

resource "google_container_node_pool" "gke_node_pool" {
  name = "nagy-node-pool"
  cluster = google_container_cluster.MYGKE.name
  node_count = "1"
  location = google_container_cluster.MYGKE.location

 node_config {
    preemptible  = true
    machine_type = "e2-small"

    service_account = google_service_account.node-acc.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
     ]
  }
}
#---->> use this to command install plugin to fetch the cluster "sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin"