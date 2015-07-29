# -*- mode: ruby -*-
# vi: set ft=ruby tabstop=2 expandtab shiftwidth=2 softtabstop=2 :

def enable_3d(cfg)
  cfg.vm.provider "virtualbox" do |v|
    v.customize ['modifyvm', :id, '--vram', 256]
    v.customize ['modifyvm', :id, '--accelerate3d', 'on']
  end
end

def ram2g(cfg)
  cfg.vm.provider "virtualbox" do |v|
    v.cpus = 2
    v.memory = 2048
  end
end

def linux(cfg)
  cfg.vm.synced_folder ".", "/vagrant", :disabled => true
  cfg.vm.synced_folder ".", "/home/vagrant/local"
  cfg.cache.scope = :box if Vagrant.has_plugin? "vagrant-cachier"
end

def osx(cfg)
  cfg.ssh.insert_key = false
  cfg.vm.synced_folder ".", "/vagrant", :disabled => true
  cfg.vm.synced_folder ".", "/Users/vagrant/local", type: "rsync"
end

Vagrant.configure("2") do |config|

  servers = {
    # ubuntu
    :ubuntu => {
      :ip => '172.118.80.41',
      :provisioner => [:linux, :ram2g],
      :box => 'ubuntu1504-desktop',
    },
    # osx
    :osx => {
      :ip => '172.118.80.42',
      :provisioner => [:osx, :ram2g, :enable_3d],
      :box => 'osx109-desktop'
    },
  }

  servers.each do |server_name, server_details|
    config.vm.define(server_name, primary: server_details.has_key?(:primary)) do |cfg|
      cfg.vm.box = server_details[:box]
      cfg.vm.host_name = server_name.to_s
      cfg.vm.network(:private_network, ip: server_details[:ip])
      (server_details[:ports] || {}).each do |host_port, guest_port|
        cfg.vm.network "forwarded_port", guest: guest_port, host: host_port
      end
      server_details[:provisioner].each { |p| method(p).call(cfg) }
    end
  end
end

