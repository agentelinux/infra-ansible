# -*- mode: ruby -*-
# vi: set ft=ruby :
# Use config.yaml for basic VM configuration.
# vagrant plugin install vagrant-disksize
# vagrant plugin install vagrant-dns

require 'yaml'
dir = File.dirname(File.expand_path(__FILE__))
config_nodes = "#{dir}/artefacts/config/config_multi-nodes.yaml"

if !File.exist?("#{config_nodes}")
  raise 'Configuration file is missing! Please make sure that the configuration exists and try again.'
end
vconfig = YAML::load_file("#{config_nodes}")

BRIDGE_NET = vconfig['vagrant_ip']
DOMAIN = vconfig['vagrant_domain_name']
RAM = vconfig['vagrant_memory']
TLD = vconfig['vagrant_dns_tld']

$install_ansible = <<SCRIPT
apt-get -y install software-properties-common
apt-add-repository ppa:ansible/ansible
apt-get -y update
apt-get -y install ansible

SCRIPT

servers=[
  {
    :hostname => "ansible." + "#{DOMAIN}",
    :ip => "#{BRIDGE_NET}" + "155",
    :ram => 4096,
    :sshd_config => "#{dir}/artefacts/scripts/sshd_config.sh",    
    :install_ansible => "#{dir}/artefacts/scripts/install_ansible.sh", 
    :config_ansible => "#{dir}/artefacts/scripts/config_ansible.sh",
    :source =>  "#{dir}/artefacts/.",
    :destination => "/home/vagrant/"
  }
]
 
Vagrant.configure(2) do |config|
  config.vm.synced_folder ".", vconfig['vagrant_directory'], :mount_options => ["dmode=777", "fmode=755"]
  config.vm.provision 'shell', inline: $install_ansible
  servers.each do |machine|
    config.vm.define machine[:hostname] do |node|
      node.dns.tld = TLD
      node.dns.patterns = machine[:hostname]
      node.vm.box = vconfig['vagrant_box']
      node.vm.box_version = vconfig['vagrant_box_version']
      node.disksize.size = '80GB'
      node.vm.hostname = machine[:hostname]
      node.vm.network "private_network", ip: machine[:ip] 

      node.vm.network "forwarded_port", guest: 8090 , host: 8090
      node.vm.network "forwarded_port", guest: 8080 , host: 8080
      node.vm.network "forwarded_port", guest: 8443 , host: 8443
      node.vm.network "forwarded_port", guest: 4440 , host: 4440
      node.vm.network "forwarded_port", guest: 10080 , host: 10080
      node.vm.network "forwarded_port", guest: 10022 , host: 10022

      node.vm.provider "virtualbox" do |vb,override|
        vb.gui = false
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vb.cpus = vconfig['vagrant_cpu']
        vb.memory = machine[:ram]
        vb.name = machine[:hostname]
      end

      if (!machine[:hostname].nil?) then
        
        if File.exist? machine[:config_ansible].to_s then
            node.vm.provision :file, source: machine[:source] , destination: machine[:destination]
        end
      end

    end
    config.vm.provision :ansible do |ansible|
      ansible.playbook = "artefacts/playbooks/main.yaml"
      ansible.galaxy_role_file = "artefacts/playbooks/requirements.yaml"
      ansible.galaxy_command = "ansible-galaxy install --role-file=%{role_file} --roles-path=%{roles_path}"
    
      #ansible.verbose = true
    end
  end
end