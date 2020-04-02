variable "region" {}
variable "sub-vpc-name" {}
variable "vpc-name" {}
variable "project" {}
variable "Name" { default = "skazak" }
variable "TagsW" { default = [ "ansible", "web" ] }
variable "TagsA" { default = [ "ansible", "app" ] }
variable "TagsD" { default = [ "ansible", "db" ] }
variable "Type" { default = "g1-small"  }
variable "DiskImage" { default = "centos-cloud/centos-7" }
variable "DiskType" { default = "pd-ssd" }
variable "DiskSize" { default = 30 }
variable "LabelST" { default = "ansible" }
variable "LabelWay" { default = "terraform" }
variable "student_name" { default = "skazak" }