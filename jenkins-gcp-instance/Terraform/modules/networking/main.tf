# Revise vars.tf for vars

resource "google_compute_subnetwork" "public-sub" {
  name          = "sub-${var.student_name}-public"
  description = "Public subnetwork app stack"
  ip_cidr_range = "10.8.1.0/24"
  region        = "${var.region}"
  network       = "${google_compute_network.vpc_network.self_link}"
}

resource "google_compute_network" "vpc_network" {
  name = "${var.student_name}-vpc"
  description = "VPC network for app stack"
  auto_create_subnetworks = false
}