provider "google" {
  credentials = "${file("my-epamlab0012-ansible-f219264cf757.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
}

terraform {
  backend "gcs" {
    bucket = "jenkins_data"
    prefix = "tfstates/"
    credentials = "my-epamlab0012-ansible-f219264cf757.json"
    }
}

module "network" {
  source = "./modules/network"
}

module "jenkins" {
  source = "./modules/jenkins"
}

module "dns" {
  source = "./modules/dns"
  jenkins = "${module.jenkins.jenkins}"

}

