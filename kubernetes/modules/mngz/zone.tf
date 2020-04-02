resource "google_dns_managed_zone" "name-zone" {
  name        = var.name
  dns_name    = var.dns_name
  description = var.description
  labels = {
    aim = "sock"
  }
}
