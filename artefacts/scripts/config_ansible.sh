#!/bin/sh

USER=vagrant
PASSWORD=vagrant

# wget https://releases.hashicorp.com/packer/1.3.4/packer_1.3.4_linux_amd64.zip
# unzip packer_1.3.4_linux_amd64.zip -d /tmp/packer
# sudo mv /tmp/packer/packer /usr/local/
# export PATH="$PATH:/usr/local/packer"
# source /etc/environment

# add addresses to /etc/hosts 
echo "192.168.99.155 ansible.sample.test" | sudo tee -a /etc/hosts 


echo " " | sudo tee -a /etc/ansible/hosts
echo "[all]" | sudo tee -a /etc/ansible/hosts
echo "ansible.sample.test" | sudo tee -a /etc/ansible/hosts 

#cat /etc/ansible/hosts
dos2unix /vagrant/artefacts/scripts/ssh_pass.sh
chmod +x /vagrant/artefacts/scripts/ssh_pass.sh
#chown vagrant:vagrant ssh_pass.sh 

# password less authentication using expect scripting language
/vagrant/artefacts/scripts/ssh_pass.sh $USER $PASSWORD "ansible.sample.test" 

ansible-playbook /vagrant/artefacts/playbooks/main.yaml


