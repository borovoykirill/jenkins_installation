output "front-ip" {
  value = "${google_compute_instance.web.network_interface.0.access_config.0.nat_ip}"
}

output "back-ip" {
  value = "${google_compute_instance.jenkins.network_interface.0.access_config.0.nat_ip}"
}