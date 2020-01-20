#!/bin/sh

clear
echo `date --rfc-3339=seconds`
chmod 755 artefacts/scripts/install_ansible.sh
artefacts/scripts/install_ansible.sh
echo `date --rfc-3339=seconds`