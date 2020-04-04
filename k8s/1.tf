provider "google" {
  credentials = "${file(".vocal-door-268207-231b2e12386e.json")}"
  project     = "${var.project}"
  region      = "${var.location}"
}

terraform {
  backend "gcs" {
    bucket      = "my-terraform-kube-bucket"
    prefix      = "tfstates/k8s/"
    credentials = ".vocal-door-268207-231b2e12386e.json"
    }
}

resource "google_container_cluster" "jenkins_k8s" {
  name        = "${var.name}"
  project     = "${var.project}"
  location    = "${var.zone}"
  description = "${var.name} production GCP cluster"
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

resource "google_container_node_pool" "jenkins_pool" {
  name       = "${var.name}"
  project    = "${var.project}"
  location   = "${var.zone}"
  cluster    = "${google_container_cluster.jenkins_k8s.name}"
  node_count = 1
  depends_on = ["google_container_cluster.jenkins_k8s"]
  node_config {
    preemptible  = true
    machine_type = "${var.machine_type}"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels   = {
      stage = "production"
    }

    tags = ["k8s", "jenkins"]
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

resource "null_resource" "localscript" {
  depends_on = ["google_container_node_pool.jenkins_pool"]
  provisioner "local-exec" {
    command = "Get-Date >> k8s_created.log"
    interpreter = ["PowerShell", "-Command"]
    environment = {
      name = "admin"
      number = 1
    }
    provisioner "local-exec" {
    command = "gcloud container clusters get-credentials jenkins --zone us-central1-c --project vocal-door-268207"
    interpreter = ["PowerShell", "-Command"]  
  }
    provisioner "local-exec" {
    command = "kubectl apply -f 1.yaml"
    interpreter = ["PowerShell", "-Command"]  
  }
}
