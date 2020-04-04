provider "google" {
  credentials = "${file("my-epamlab0012-ansible-f219264cf757.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
}


terraform {
  backend "gcs" {
    bucket = "jenkins_data"
    prefix = "k8s-tfstates/"
    credentials = "my-epamlab0012-ansible-f219264cf757.json"
    }
}


module "jenkins" {
  source = "./modules/jenkins"
}
