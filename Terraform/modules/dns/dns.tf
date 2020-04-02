variable "server_ip" {}

/*resource "google_dns_managed_zone" "jankins" {
  name        = "${var.dnszone}-dnszone"
  dns_name    = "${var.dnszone}."
  description = "${var.dnszone} DNS zone"
  visibility  = "public"
  labels      = {
        stage = "production"
  }
}*/

resource "google_dns_record_set" "jenkins_server" {
  name = "jenkins.abatura.playpit.net."
  type = "A"
  ttl  = 10
  managed_zone = "socks-shop-dnszone"
  rrdatas = ["${var.server_ip}"]
}