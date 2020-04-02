provider "google" {
  credentials = "${file(".vocal-door-268207-231b2e12386e.json")}"
  project     = "${var.project}"
  region      = "${var.location}"
}

terraform {
  backend "gcs" {
    bucket      = "my-terraform-kube-bucket"
    prefix      = "tfstates/ansible/"
    credentials = ".vocal-door-268207-231b2e12386e.json"
    }
}

#Create ANSIBLE CONTROL SERVER
resource "google_compute_instance" "epam-cin-jenkins" {
  name         = "${var.name}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"
  deletion_protection = "false"
  network_interface {
    network    = "default"
    access_config {}
  }
  count        = 1

  metadata_startup_script = <<EOF
#!/bin/bash

until [[ "$rez" = "0%" ]]
do
rez=$(ping -c 1 8.8.8.8 | grep % | cut -d ' ' -f6)
echo "No internet"
done
echo "Internet available"

sudo apt-get -y update
sudo apt install -y jq
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo apt install python -y
python get-pip.py --user
sudo apt install -y python-pip
pip install -U pip
sudo pip install ansible
pip install requests google-auth
sudo apt install python-requests -y
#gsutil cp -r gs://my-terraform-kube-bucket/jenkins/HW1/* /home/ablinuxdevops/jenkins/
cd /home/ablinuxdevops/
git clone https://github.com/AndreiSan/JENKINS.git
sudo chown ablinuxdevops: -R /home/ablinuxdevops/JENKINS/
export ANSIBLE_GATHERING=smart
export ansible_python_interpreter=auto
#export ANSIBLE_VAULT_PASSWORD_FILE=./files/.ansible_vault
cd /home/ablinuxdevops/JENKINS/Ansible
ansible-playbook 1.yml
EOF

  tags = ["http-server","cm-server"]
  boot_disk {
   initialize_params {
     type = "pd-ssd"
     image = "ubuntu-1804-bionic-v20200317"
     size = "15"
   }
  }
  lifecycle {
    ignore_changes = ["attached_disk"]
  }

  metadata = {
    sshKeys = "ablinuxdevops:${file("./files/id_rsa.pub")}"
  }

  tags = ["http-server","https-server","jenkins","ssh"]
  labels = {
    app               = "jenkins"
    servertype        = "ansibleserver"
    osfamily          = "debian"
    wayofinstallation = "terraform"
  }

/*    provisioner "file" {
        source = "./files.tar"
        destination = "/tmp/files.tar"
        connection {
            type = "ssh"
            user = "student"
            private_key = "${file("~/.ssh/id_rsa")}"
        }
    }*/
}

module "network" {
  source = "./modules/network"
}

module "dns" {
  source = "./modules/dns"
  server_ip = "${google_compute_instance.epam-cin-jenkins.network_interface.0.access_config.0.nat_ip}"
}
