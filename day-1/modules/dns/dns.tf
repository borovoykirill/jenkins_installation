variable "jenkins"{}

resource "google_dns_record_set" "ubuntu-jenkins" {
  name = "jenkins.kbaravoy.playpit.by."
  type = "A"
  ttl  = 300

  managed_zone = "kbaravoy-zone"

  rrdatas = ["${var.jenkins}"]
}