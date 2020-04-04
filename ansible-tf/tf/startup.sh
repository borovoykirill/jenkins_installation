#!/bin/bash

until [[ "$rez" = "0%" ]]
do
rez=$(ping -c 1 8.8.8.8 | grep % | cut -d ' ' -f6)
echo "No internet"
done
echo "Internet is here"
yum install git ansible -y
cd /tmp
git clone https://github.com/Vitalyazavr/jenkinksD1.git
ansible-playbook /tmp/jenkinksD1/playbook.yml