variable "jenkins"{}

#resource "google_dns_managed_zone" "mfilipovich-zone" {
#  name        = "mfilipovich-zone"
#  dns_name    = "mfilipovich.playpit.net."
#  description = "ansible DNS zone"
#  visibility = "public"
#}

#resource "google_dns_record_set" "ubuntu-jenkins" {
#  name = "jenkins.${google_dns_managed_zone.mfilipovich-zone.dns_name}"
#  type = "A"
#  ttl  = 300
#
#  managed_zone = google_dns_managed_zone.mfilipovich-zone.name
#
#  rrdatas = ["${var.jenkins}"]
#}

resource "google_dns_record_set" "ubuntu-jenkins" {
  name = "jenkins.mfilipovich.playpit.net."
  type = "A"
  ttl  = 300

  managed_zone = "mfilipovich-zone"

  rrdatas = ["${var.jenkins}"]
}