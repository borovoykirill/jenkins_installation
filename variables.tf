variable "project" {
  default = "directed-fabric-271613"
}

variable "region" {
  default  = "us-central1"
}
 

variable "region_zone" {
  default  = "us-central1-c"
}

variable "name" {
  default = "vm-with-jenkins"
}

variable "mtype" {
  default = "n1-standard-1"
}

variable "image" {
  default ="ubuntu-os-cloud/ubuntu-1804-lts"
}

variable "size_disk" {
  default = "25"
}

variable "type_disk" {
  default = "pd-ssd"
}

