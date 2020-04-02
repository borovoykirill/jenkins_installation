provider "google" {
  credentials = "${file(".luckypro.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
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

