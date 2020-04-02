provider "google" {
  credentials = file("terraform-admin.json")
  project     = "${var.project}"
  zone      = "${var.zone}"
}

module "network" {
  source = "./modules/network"
}

module "jenkins" {
  source = "./modules/jenkins"
}