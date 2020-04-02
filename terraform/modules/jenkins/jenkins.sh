#!/bin/bash
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
cd /home/dimaepam2020/

git clone https://github.com/locky326/jenkins_ansible.git

cd /home/dimaepam2020/jenkins_ansible
sudo chown dimaepam2020:dimaepam2020 -R /home/dimaepam2020/jenkins_ansible
export ANSIBLE_GATHERING=smart
export ansible_python_interpreter=auto
ansible-playbook jenkins.yml
echo "finished"