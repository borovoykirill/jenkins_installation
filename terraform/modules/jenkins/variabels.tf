
variable "region_zone" {
  default  = ["us-central1-c"]
}

variable "name" {
  type="list"
  default = ["ubuntu-jenkins"]
}

variable "mtype" {
  default = ["custom-1-4608"]
}

variable "image" {
  default = [
  "ubuntu-os-cloud/ubuntu-1804-lts"
  ]
}

variable "size_disk" {
  default = ["10"]
}

variable "type_disk" {
  default = ["pd-ssd", "pd-standard"]
}

variable "label" {
  default = [
  "nginxserver", //0
  "debian",      //1
  "redhat",      //2
  "terraform",   //3
  "bastion",     //4
  "jenkins",  //5 
]
}