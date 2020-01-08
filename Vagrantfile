# -*- mode: ruby -*-
# vi: set ft=ruby :
# Use config.yaml for basic VM configuration.

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

servers=[
  {
    :hostname => "nfsserver." + "#{DOMAIN}",
    :ip => "#{BRIDGE_NET}" + "150",
    :ram => 1024,
    :sshd_config => "#{dir}/artefacts/scripts/sshd_config.sh"
  },
  {
    :hostname => "nfsclient." + "#{DOMAIN}",
    :ip => "#{BRIDGE_NET}" + "151",
    :ram => 1024,
    :sshd_config => "#{dir}/artefacts/scripts/sshd_config.sh"    
  },
  {
    :hostname => "docker." + "#{DOMAIN}",
    :ip => "#{BRIDGE_NET}" + "152",
    :ram => 2048,
    :sshd_config => "#{dir}/artefacts/scripts/sshd_config.sh"    
  },
  {
    :hostname => "jenkins." + "#{DOMAIN}",
    :ip => "#{BRIDGE_NET}" + "153",
    :ram => "#{RAM}",
    :sshd_config => "#{dir}/artefacts/scripts/sshd_config.sh",    
    :guest_j => 80,
    :host_j => 8080,
    :sguest_j => 443,
    :shost_j => 8443 
  },
  {
    :hostname => "gitlab." + "#{DOMAIN}",
    :ip => "#{BRIDGE_NET}" + "154",
    :ram => "#{RAM}",
    :sshd_config => "#{dir}/artefacts/scripts/sshd_config.sh", 
    :guest_g => 80,
    :host_g => 9080,
    :sguest_g => 443,
    :shost_g => 9443 
  },
  {
    :hostname => "ansible." + "#{DOMAIN}",
    :ip => "#{BRIDGE_NET}" + "155",
    :ram => 1024,
    :sshd_config => "#{dir}/artefacts/scripts/sshd_config.sh",    
    :install_ansible => "#{dir}/artefacts/scripts/install_ansible.sh", 
    :config_ansible => "#{dir}/artefacts/scripts/config_ansible.sh",
    :source =>  "#{dir}/artefacts/.",
    :destination => "/home/vagrant/"
  }
]
 
Vagrant.configure(2) do |config|
  config.vm.synced_folder ".", vconfig['vagrant_directory'], :mount_options => ["dmode=777", "fmode=755"]
  servers.each do |machine|
    config.vm.define machine[:hostname] do |node|
      node.dns.tld = TLD
      node.dns.patterns = machine[:hostname]
      node.vm.box = vconfig['vagrant_box']
      node.vm.box_version = vconfig['vagrant_box_version']
      node.vm.hostname = machine[:hostname]
      node.vm.network "private_network", ip: machine[:ip] 

      node.vm.provider "virtualbox" do |vb,override|
        vb.gui = false
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vb.cpus = vconfig['vagrant_cpu']
        vb.memory = machine[:ram]
        vb.name = machine[:hostname]
      end

      if (!machine[:hostname].nil?) then

        if machine[:guest_g].to_s then
          node.vm.network "forwarded_port", guest: machine[:guest_g].to_s , host: machine[:host_g].to_s
          node.vm.network "forwarded_port", guest: machine[:sguest_g].to_s , host: machine[:shost_g].to_s
        end

        if machine[:guest_j].to_s then
          node.vm.network "forwarded_port", guest: machine[:guest_j].to_s , host: machine[:host_j].to_s
          node.vm.network "forwarded_port", guest: machine[:sguest_j].to_s , host: machine[:shost_j].to_s
        end

        if File.exist? machine[:sshd_config].to_s then
          node.vm.provision :shell, path: machine[:sshd_config]
        end
        
        if File.exist? machine[:install_ansible].to_s then
          node.vm.provision :shell, path: machine[:install_ansible]
        end

        if File.exist? machine[:config_ansible].to_s then
            node.vm.provision :file, source: machine[:source] , destination: machine[:destination]
            node.vm.provision :shell, privileged: false, path: machine[:config_ansible]
        end
      end

    end
  end
end