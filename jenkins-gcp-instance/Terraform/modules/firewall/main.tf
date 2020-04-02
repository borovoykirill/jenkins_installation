# Revise vars.tf for vars

# Revise vars.tf for vars

resource "google_compute_firewall" "internal" {
  name    = "${var.FirewallName}-internal"
  network = "${var.vpc-name}"
  description = "jenkins internal firewall"
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["0-65535"]
  }
  target_tags = ["ansible"]
  source_tags = ["ansible"]
}

resource "google_compute_firewall" "external" {
  name    = "${var.FirewallName}-ext"
  network = "${var.vpc-name}"
  description = "jenkins external firewall"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["80", "22", "8080"]
  }
  source_ranges = ["0.0.0.0/0"]
}