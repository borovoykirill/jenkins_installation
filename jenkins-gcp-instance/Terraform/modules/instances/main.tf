# Revise vars.tf for vars

data "google_compute_zones" "available" {}

resource "google_compute_instance" "web" {
  name = "${var.Name}-front"  
  description = "Web instance"
  deletion_protection = false
  project = "${var.project}"
  zone = "${var.region}-a"
  machine_type = "${var.Type}"
  tags  =  "${var.TagsW}"

  boot_disk {
    initialize_params {
      image = "${var.DiskImage}"
      type = "${var.DiskType}"
      size = "${var.DiskSize}"
    }
  }

  metadata = {
    ssh-keys = "devops:${file("../files/devops.ssh.id-rsa.pub")}"
  }

  labels {
    servertype = "${var.LabelST}"
    wayofinstallation = "${var.LabelWay}"
  }

  network_interface {
    network = "${var.vpc-name}"
    subnetwork = "${var.sub-vpc-name}"
    network_ip = "10.8.1.2"
    access_config = {
    }
  }
}

resource "google_compute_instance" "jenkins" {
  name = "${var.Name}-jenkins"  
  description = "Jenkins instance"
  deletion_protection = false
  project = "${var.project}"
  zone = "${var.region}-a"
  machine_type = "n1-standard-1"
  tags  =  "${var.TagsA}"

  boot_disk {
    initialize_params {
      image = "${var.DiskImage}"
      type = "${var.DiskType}"
      size = "${var.DiskSize}"
    }
  }

  metadata = {
    ssh-keys = "devops:${file("../files/devops.ssh.id-rsa.pub")}"
  }
  
  labels {
    servertype = "${var.LabelST}"
    wayofinstallation = "${var.LabelWay}"
  }

  network_interface {
    network = "${var.vpc-name}"
    subnetwork = "${var.sub-vpc-name}"
    network_ip = "10.8.1.3"
    access_config = {
    }
  }
}

# resource "google_compute_instance" "db" {
#   name = "${var.Name}-db01"  
#   description = "App instance"
#   deletion_protection = false
#   project = "${var.project}"
#   zone = "${var.region}-a"
#   machine_type = "${var.Type}"
#   tags  =  "${var.TagsD}"

#   boot_disk {
#     initialize_params {
#       image = "${var.DiskImage}"
#       type = "${var.DiskType}"
#       size = "${var.DiskSize}"
#     }
#   }

#   metadata = {
#     ssh-keys = "devops:${file("../files/devops.ssh.id-rsa.pub")}"
#   }

#   labels {
#     servertype = "${var.LabelST}"
#     wayofinstallation = "${var.LabelWay}"
#   }

#   network_interface {
#     network = "${var.vpc-name}"
#     subnetwork = "${var.sub-vpc-name}"
#     network_ip = "10.8.1.4"
#     access_config = {
#     }
#   }
# }