variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

variable "location" {
  description = "Main location of the project."
  default     = ""
}

variable "zone" {
  description = "Availability zone in the region"
  default     = ""
}

variable "dnszone" {
  description = "DNS zone"
  default     = ""
}

variable "sdn" {
  description = "subdomain name"
  default     = ""
}

variable "project" {default = ""}

variable "machine_type" {default = ""}

variable "server_ip" {default = ""}

variable "initial_node_count" {default = ""}