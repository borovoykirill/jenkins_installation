# Using Terraform create 2 K8s clusters on CGP (Prod: 1 master, 3 workers, Stage: 1 master, 1 worker)
# Configure client access from workstation
# Deploy microservice application stack: https://microservices-demo.github.io/
# Create a report and send to Siarhei_Beliakou@epam.com

variable "project" {
  description = "project name"
  default = "glassy-hue-268209"
}

variable "zone" {
  description = "project name"
  default = "europe-west4-a"
}
