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
#echo "192.168.99.154 gitlab.sample.test" | sudo tee -a /etc/hosts 
#echo "192.168.99.153 jenkins.sample.test" | sudo tee -a /etc/hosts 
#echo "192.168.99.152 docker.sample.test" | sudo tee -a /etc/hosts 
#echo "192.168.99.151 nfsclient.sample.test" | sudo tee -a /etc/hosts
#echo "192.168.99.150 nfsserver.sample.test" | sudo tee -a /etc/hosts  

echo " " | sudo tee -a /etc/ansible/hosts
echo "[all]" | sudo tee -a /etc/ansible/hosts
echo "ansible.sample.test" | sudo tee -a /etc/ansible/hosts 
#echo "jenkins.sample.test" | sudo tee -a /etc/ansible/hosts 
#echo "docker.sample.test" | sudo tee -a /etc/ansible/hosts 
#echo "nfsclient.sample.test" | sudo tee -a /etc/ansible/hosts
#echo "nfsserver.sample.test" | sudo tee -a /etc/ansible/hosts  

echo " " | sudo tee -a /etc/ansible/hosts
echo "[test]" | sudo tee -a /etc/ansible/hosts
#echo "nfsserver.sample.test" | sudo tee -a /etc/ansible/hosts
#echo "nfsclient.sample.test" | sudo tee -a /etc/ansible/hosts
echo "ansible.sample.test" | sudo tee -a /etc/ansible/hosts 

echo " " | sudo tee -a /etc/ansible/hosts
echo "[nfs-server]" | sudo tee -a /etc/ansible/hosts
#echo "nfsserver.sample.test" | sudo tee -a /etc/ansible/hosts
echo "ansible.sample.test" | sudo tee -a /etc/ansible/hosts 

echo " " | sudo tee -a /etc/ansible/hosts
echo "[nfs-clients]" | sudo tee -a /etc/ansible/hosts
#echo "nfsclient.sample.test" | sudo tee -a /etc/ansible/hosts
echo "ansible.sample.test" | sudo tee -a /etc/ansible/hosts 

echo " " | sudo tee -a /etc/ansible/hosts
echo "[jenkins]" | sudo tee -a /etc/ansible/hosts
#echo "jenkins.sample.test" | sudo tee -a /etc/ansible/hosts
echo "ansible.sample.test" | sudo tee -a /etc/ansible/hosts 

echo " " | sudo tee -a /etc/ansible/hosts
echo "[docker]" | sudo tee -a /etc/ansible/hosts
#echo "docker.sample.test" | sudo tee -a /etc/ansible/hosts
echo "ansible.sample.test" | sudo tee -a /etc/ansible/hosts 

echo " " | sudo tee -a /etc/ansible/hosts
echo "[gitlab]" | sudo tee -a /etc/ansible/hosts
#echo "gitlab.sample.test" | sudo tee -a /etc/ansible/hosts
echo "ansible.sample.test" | sudo tee -a /etc/ansible/hosts 

#cat /etc/ansible/hosts
dos2unix /vagrant/artefacts/scripts/ssh_pass.sh
chmod +x /vagrant/artefacts/scripts/ssh_pass.sh
#chown vagrant:vagrant ssh_pass.sh 

# password less authentication using expect scripting language
/vagrant/artefacts/scripts/ssh_pass.sh $USER $PASSWORD "ansible.sample.test" 
#/vagrant/artefacts/scripts/ssh_pass.sh $USER $PASSWORD "nfsclient.sample.test" 
#/vagrant/artefacts/scripts/ssh_pass.sh $USER $PASSWORD "nfsserver.sample.test" 
#/vagrant/artefacts/scripts/ssh_pass.sh $USER $PASSWORD "docker.sample.test" 
#/vagrant/artefacts/scripts/ssh_pass.sh $USER $PASSWORD "jenkins.sample.test"
#/vagrant/artefacts/scripts/ssh_pass.sh $USER $PASSWORD "gitlab.sample.test"

#ansible-playbook /vagrant/artefacts/playbooks/nfs_server.yaml
#ansible-playbook /vagrant/artefacts/playbooks/nfs_clients.yaml
#ansible-playbook /vagrant/artefacts/playbooks/install_java.yaml
#ansible-playbook /vagrant/artefacts/playbooks/install_jenkins.yaml
#ansible-playbook /vagrant/artefacts/playbooks/install_docker.yaml
#ansible-playbook /vagrant/artefacts/playbooks/install_gitlab.yaml


