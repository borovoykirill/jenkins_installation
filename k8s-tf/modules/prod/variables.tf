variable "project" {
  description = "project name"
  default = "glassy-hue-268209"
}

variable "cluster_name" {
  description = "project name"
  default = "jenkins-dev-cluster"
}

variable "node_name" {
  description = "project name"
  default = "jenkins-prod-node"
}

variable "zone" {
  description = "project name"
  default = "europe-west4-a"
}

variable "machine_type" {
  default = "n1-standard-1"  
}

variable "node_count" {
  description = "describe your variable"
  default = 1
}