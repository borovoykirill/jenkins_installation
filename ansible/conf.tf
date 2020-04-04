provider "google" {
  credentials = file("task4-gcplabproject-0567ed530d23.json")
  project     = "task4-gcplabproject"
  region      = "europe-west3-c"
}


resource "google_compute_instance_template" "tpl" {
  name         = "template"
  machine_type = "n1-standard-1"
  region = "europe-west3"


  disk {
    source_image = "ubuntu-os-cloud/ubuntu-1804-lts"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    ssh-keys = "devops:${file("devops.ssh.id-rsa.pub")}"

    # startup-script = <<SCRIPT
    # apt-get update
    # apt-get install ansible -y
    # SCRIPT
  }

  can_ip_forward = true
}

resource "google_compute_instance_from_template" "first" {
  name = "nginx"
  zone = "europe-west3-c"

  tags = ["http-server"]

  source_instance_template = google_compute_instance_template.tpl.self_link

  depends_on = [google_compute_instance_from_template.second]

}


resource "google_compute_instance_from_template" "second" {
  name = "jenkins"
  zone = "europe-west3-c"

  source_instance_template = google_compute_instance_template.tpl.self_link

}

output "jenkins-ip" {
  value = "${google_compute_instance_from_template.second.network_interface.0.access_config.0.nat_ip}"
}

output "nginx-ip" {
  value = "${google_compute_instance_from_template.first.network_interface.0.access_config.0.nat_ip}"
}

