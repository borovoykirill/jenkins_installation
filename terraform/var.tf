variable "vm-name" {
	default = "jenkins"
}

variable "zone" {
	default = "europe-west4-b"
}

variable "network" {
	default = "default"
}

variable "mtype" {
	default = "n1-standard-2"
}

variable "protection" {
	default = "false"
}

variable "lab-servertype" {
	default = "jenkins"
}

variable "lab-osfamily" {
	default = "redhat"
}

variable "lab-wayofinstallation" {
	default = "terraform"
}

variable "disktype" {
	default = "pd-ssd"
}

variable "image" {
	default = "centos-cloud/centos-7"
}

variable "disksize" {
	default = "30"
}
