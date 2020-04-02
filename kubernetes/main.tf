module "stage" {
  source = "./modules/stage"
  name			= "stage"
  location		= "europe-west3-a"
  initial_node_count	= 1
  node_pool_name	= "stage-node-pool"
  node_count		= 1
  machine_type		= "n1-standard-2"
}


#module "prod" {
#  source = "./modules/prod"
#
#  name			= "prod"
#  location		= "europe-west2"
#  initial_node_count	= 1
#  node_pool_name	= "prod-node-pool"
#  node_count		= 1
#  machine_type		= "g1-small"
#}

#module "mngz" {
#  source = "./modules/mngz"
#
#  name			= "yoursh"
#  dns_name		= "ayoursh.playpit.net."
#  description		= "mydns"
#}
