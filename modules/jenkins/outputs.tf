output "jenkins" {
    value = "${google_compute_instance.ubuntu-jenkins.network_interface.0.access_config.0.nat_ip}"
               
}
