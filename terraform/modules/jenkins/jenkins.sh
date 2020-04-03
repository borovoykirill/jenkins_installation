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
sudo useradd karunaspavel -m
cd /home/karunaspavel/
git clone https://github.com/PavelKarunas/test_repository.git
cd /home/karunaspavel/test_repository
sudo chown karunaspavel:karunaspavel -R /home/karunaspavel/test_repository
export ANSIBLE_GATHERING=smart
export ansible_python_interpreter=auto
ansible-playbook jenkins.yml
