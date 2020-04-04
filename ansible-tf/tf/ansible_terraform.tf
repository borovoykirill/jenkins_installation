provider "google" {
  credentials = file("account.json")
  project     = "${var.project}"
  region      = "${var.zone}"
}

resource "google_compute_instance" "default" {
  count = "${var.instance_count}"
  name = "jenkins-web-${count.index + 1}"
  zone = "${var.zone}"

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

  machine_type        = "n1-standard-2"

  tags = ["http-server", "https-server"]
  
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size  = "40"
    }
  }
  metadata_startup_script = "${file("startup.sh")}"
}

