resource "google_compute_firewall" "jenkins" {
  name    = "jenkins"
  network = "default"
  description = "open port 8080 and 50000"
  allow {
    protocol = "tcp"
    ports    = ["50000","8080"]
  }
  target_tags = ["jenkins"]
}
