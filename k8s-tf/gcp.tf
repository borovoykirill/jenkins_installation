provider "google" {
  credentials = "${file(".account.json")}"
  project     = "${var.project}"
  region      = "${var.zone}"
}

module "prod" {
  source = "./modules/prod"
}

# module "stage" {
#   source = "./modules/stage"
# }