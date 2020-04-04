provider "google" {
  credentials = file("task4-gcplabproject-0567ed530d23.json")
  project     = "task4-gcplabproject"
  region      = "europe-west3-c"
}


resource "google_container_cluster" "primary" {
  name               = "jenkins-clstr"
  location           = "europe-west3-c"
  initial_node_count = 2

  master_auth {
    username = "mbazhok"
    password = "anothertestcluster"

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }


  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}
