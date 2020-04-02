# Revise variables.tf for vars

module "networking" {
  source = "./modules/networking"
  region = "${var.Region}"
}

module "firewall" {
  source = "./modules/firewall"
  vpc-name = "${module.networking.vpc-name}"
  host-ip = "${var.Host_ip}"
}

module "instances" {
  source = "./modules/instances"
  project = "${var.Project}"
  region = "${var.Region}"
  vpc-name = "${module.networking.vpc-name}"
  sub-vpc-name = "${module.networking.sub-vpc-public-name}"
}

provider "google" {
  credentials = "${file("./devops2020-kubernetes.json")}"
  project = "${var.Project}"
  region = "${var.Region}"
  version = "2.20"
}

# Outputs

output "Front-end IP" {
  value = "${module.instances.front-ip}"
}

output "Jenkins IP" {
  value = "${module.instances.back-ip}"
}