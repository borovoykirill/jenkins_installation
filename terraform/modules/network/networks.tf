resource "google_compute_firewall" "jenkins-50000" {
  name    = "jenkins-50000"
  network = "default"
  description = "open port 50000"
  allow {
    protocol = "tcp"
    ports    = ["50000"]
  }
  target_tags = ["jenkins-50000"]
}

resource "google_compute_firewall" "jenkins-8080" {
  name    = "jenkins-8080"
  network = "default"
  description = "open port 8080"
  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
  target_tags = ["jenkins-8080"]
}