resource "google_container_cluster" "jenkins" {
  name     = "jenkins"
  location   = "us-central1-c"

  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "jenkins_nodes" {
  name       = "jenkins-node-pool"
  cluster    = google_container_cluster.jenkins.name
  node_count = 1
  location   = "us-central1-c"
  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }
    labels = {
      servertype = "${var.label[5]}"
      osfamily= "${var.label[1]}"
      wayofinstallation= "${var.label[3]}"
    }

    tags = ["http-server","https-server", "jenkins-8080", "jenkins-50000", "ssh"]

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

resource "null_resource" "localscript" {
  depends_on = ["google_container_node_pool.jenkins_nodes"]
 
    provisioner "local-exec" {
    command = "gcloud container clusters get-credentials jenkins --zone us-central1-c --project my-epamlab0012-ansible"
    interpreter = ["PowerShell", "-Command"]  
  }
    provisioner "local-exec" {
    command = "kubectl apply -f jenkins.yaml"
    interpreter = ["PowerShell", "-Command"]  
  }
}