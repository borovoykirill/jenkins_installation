resource "google_compute_instance" "ubuntu-jenkins" {
  name         = "${var.name[0]}"
  machine_type = "${var.mtype[1]}"
  zone         = "${var.region_zone[1]}"
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
      image = "${var.image[0]}"
      size = "${var.size_disk[1]}"
      type = "${var.type_disk[0]}"
   }
 }
 lifecycle {
    ignore_changes = ["attached_disk"]
  }
  metadata_startup_script = "${file("./modules/jenkins/jenkins.sh")}"
}