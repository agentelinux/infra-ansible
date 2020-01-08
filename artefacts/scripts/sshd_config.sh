#!/bin/sh

# Change to enable any user
sed -i "s/.*PasswordAuthentication.*/PasswordAuthentication yes/g" /etc/ssh/sshd_config

# Restart sshd
service ssh restart