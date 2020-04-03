# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "virtualbox" do |vb|
    config.vm.box = "trusty64"
  end
  config.vm.provider "libvirt" do |vb|
    config.vm.box = "ubuntu/xenial64"
  end

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.include_offline = true

  config.vm.define "machine"
  config.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/site.yml"
      ansible.groups = { "vcl-webservers" => ["machine"] }
      ansible.extra_vars = "ansible/env_vars/vagrant.yml"
      ansible.config_file = 'ansible/ansible.cfg'
      # Uncomment to include local AWS test vars, overriding vagrant vars above.
      # ansible.raw_arguments = ["--extra-vars", "@~/Dropbox/ansible/group_vars/vcl-webservers.yaml"]
  end
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 443, host: 8443

  config.ssh.forward_agent = true
end
