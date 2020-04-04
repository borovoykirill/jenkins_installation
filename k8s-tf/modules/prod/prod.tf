resource "google_container_cluster" "default" {
  name               = "${var.cluster_name}"
  location           = "${var.zone}"
  initial_node_count = 1
  remove_default_node_pool = true
  
  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "default" {
  name       = "${var.node_name}"
  project     = "${var.project}"
  location   = "${var.zone}"
  cluster    = "${google_container_cluster.default.name}"
  node_count = "${var.node_count}"

  node_config {
    preemptible  = true
    machine_type = "${var.machine_type}"

    metadata = {
      disable-legacy-endpoints = "true"
    }
  
    tags = ["prod"]

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}