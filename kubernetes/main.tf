module "stage" {
  source = "./modules/stage"
  name			= "stage"
  location		= "europe-west3-a"
  initial_node_count	= 1
  node_pool_name	= "stage-node-pool"
  node_count		= 1
  machine_type		= "n1-standard-2"
  gcloud_command	= "gcloud container clusters get-credentials stage --zone europe-west3-a --project artsemiyoursh-day1proj-268813"
  script		= "/bin/bash script/script.sh"
}
