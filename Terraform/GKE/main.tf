resource "google_compute_network" "vpc_network" {
  name = "my-vpc-network"
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "my-subnetwork"
  ip_cidr_range  = "10.0.0.0/16"
  network        = google_compute_network.vpc_network.id
  region         = var.region
}

resource "google_container_cluster" "gke_cluster" {
  name     = "my-gke-cluster"
  location = var.region

  initial_node_count = 3

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  network    = google_compute_network.vpc_network.id
  subnetwork = google_compute_subnetwork.subnetwork.id
}

resource "google_container_node_pool" "node_pool" {
  name     = "my-node-pool"
  location = var.region
  cluster  = google_container_cluster.gke_cluster.id

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  initial_node_count = 2
}

output "kube_config" {
  value = google_container_cluster.gke_cluster.endpoint
}
