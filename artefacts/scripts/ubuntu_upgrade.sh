#!/bin/sh

# Install Ansible repository.
apt -y update
apt -y upgrade
apt -y dist-upgrade
apt autoremove -y
apt install update-manager-core -y
do-release-upgrade
do-release-upgrade -d

echo "Run --> reboot"