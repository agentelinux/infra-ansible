#!/bin/sh
apt-add-repository ppa:ansible/ansible -y

# Install Ansible.
apt-get update
apt-get install ansible -y

# Install expect, dos2unix & tree
apt-get install expect -y 
apt-get install dos2unix -y
apt-get install tree -y 

# Cleanup unneded packages
apt-get -y autoremove

# lsb_release -a

sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# generating password configuration on ansible server to later access remote servers
echo digitalhouse | sudo -S su - digitalhouse -c "ssh-keygen -t rsa -f /home/digitalhouse/.ssh/id_rsa -q -P ''"
