provider "google" {
  credentials = "${file("directed-fabric.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
}

resource "google_compute_firewall" "jenkins-50000" {
  name    = "jenkins-50000"
  network = "default"
  description = "open port 50000"
  allow {
    protocol = "tcp"
    ports    = ["50000"]
  }
  target_tags = ["jenkins-50000"]
}

resource "google_compute_firewall" "jenkins-8080" {
  name    = "jenkins-8080"
  network = "default"
  description = "open port 8080"
  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
  target_tags = ["jenkins-8080"]
}

resource "google_compute_instance" "ubuntu-jenkins" {
  name         = "${var.name}"
  machine_type = "${var.mtype}"
  zone         = "${var.region_zone}"
  deletion_protection = "false"
  network_interface {
    network    = "default"
    access_config {}
  }

 tags = ["http-server","https-server", "jenkins-8080", "jenkins-50000", "ssh"]
 boot_disk {
    initialize_params {
      image = "${var.image}"
      size = "${var.size_disk}"
      type = "${var.type_disk}"
   }
 }
 lifecycle {
    ignore_changes = ["attached_disk"]
  }
  metadata_startup_script = "${file("./jenkins.sh")}"
}

resource "google_dns_record_set" "ubuntu-jenkins" {
  name = "jenkins.abrytsikava.playpit.net."
  type = "A"
  ttl  = 300

  managed_zone = "abrytsikava-zone"

  rrdatas = ["${google_compute_instance.ubuntu-jenkins.network_interface.0.access_config.0.nat_ip}"]
}


