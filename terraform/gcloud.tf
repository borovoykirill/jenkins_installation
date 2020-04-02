provider "google" {
  credentials = "${file("artsemiyoursh-day1proj-268813-54c51c38f276.json")}"
  project     = "artsemiyoursh-day1proj-268813"
  region      = "europe-west4"
}

data "google_compute_zones" "available" {}

resource "google_compute_instance" "jenkins" {
 name         = "${var.vm-name}"
 zone         = "${var.zone}"
 network_interface {
    network = "${var.network}"
    access_config {
      
    }
 }
 machine_type = "${var.mtype}"
 deletion_protection = "${var.protection}"
 labels = {
    servertype = "${var.lab-servertype}"
    osfamily= "${var.lab-osfamily}"
    wayofinstallation= "${var.lab-wayofinstallation}"
  }
  metadata = {
    sshKeys = "student:${file("id_rsa.pub")}"
  }
 tags = ["http-server","https-server"]
 boot_disk {
   initialize_params {
     type = "${var.disktype}"
     image = "${var.image}"
     size = "${var.disksize}"
   }
 }
 lifecycle {
    
  }
 metadata_startup_script = "${file("script.sh")}"

}

resource "google_dns_record_set" "yoursh" {
  name = "jenkins.ayoursh.playpit.net."
  type = "A"
  ttl  = 300

  managed_zone = "yoursh"

  rrdatas = ["${google_compute_instance.jenkins.network_interface.0.access_config.0.nat_ip}"]
}
