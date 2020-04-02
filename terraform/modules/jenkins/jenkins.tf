resource "google_compute_instance" "ubuntu-jenkins" {
  name         = "${var.name}"
  machine_type = "${var.mtype}"
  zone         = "${var.region_zone}"
  deletion_protection = "false"
  network_interface {
    network    = "default"
    access_config {}
  }

 labels = {
    servertype = "${var.label[5]}"
    osfamily= "${var.label[1]}"
    wayofinstallation= "${var.label[3]}"
  }

 tags = ["http-server","https-server", "jenkins-8080", "jenkins-50000", "ssh"]
 boot_disk {
    initialize_params {
      image = "${var.image}"
      size = "${var.size_disk}"
      type = "${var.type_disk[0]}"
   }
 }
 lifecycle {
    ignore_changes = ["attached_disk"]
  }
  metadata_startup_script = "${file("./modules/jenkins/jenkins.sh")}"
}