variable "jenkins"{}


resource "google_dns_record_set" "ubuntu-jenkins" {
  name = "jenkins.dshishkovets.playpit.net."
  type = "A"
  ttl  = 300

  managed_zone = "dshishkovets-zone"

  rrdatas = ["${var.jenkins}"]
}