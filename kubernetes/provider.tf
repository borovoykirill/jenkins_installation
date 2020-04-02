provider "google" {
  credentials = "${file(var.credentials)}"
  project     = var.project_id
  region      = var.region
}

variable "credentials" {
  type        = string
  description = "Location of the credentials keyfile."
}

variable "project_id" {
  type        = string
  description = "The project ID to host the cluster in."
}

variable "region" {
  type        = string
  description = "The region to host the cluster in."
}
