variable "name" {
  type        = string
  description = "Name of cluster"
}

variable "location" {
  type        = string
  description = "Location of cluster"
}

variable "initial_node_count" {
  type        = number
}

variable "node_pool_name" {
  type        = string
}

variable "node_count" {
  type        = number
}

variable "machine_type" {
  type        = string
}
