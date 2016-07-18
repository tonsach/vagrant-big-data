# -*- mode: ruby -*-
# vi: set ft=ruby :

#Vagrant::Config.run do |config|
Vagrant.configure("2") do |config|
  config.vm.box = "base-hadoop"
  config.vm.provider :virtualbox do |vb|
     vb.customize ["modifyvm", :id, "--memory", 1024, "--cpus", "1"]
  end
  #config.vm.provision :puppet do |puppet|
  config.vm.provision "puppet" do |puppet|
     puppet.manifests_path = "manifests"
     puppet.manifest_file  = "base-hadoop.pp"
     puppet.module_path = "modules"
  end
  
  #config.vm.network "forward_port", guest: 50070, host: 50070
  config.vm.host_name = "master"

  #config.vm.define :master do |master_config|
    #master_config.vm.network :hostonly, "192.168.1.10"
    #master_config.vm.host_name = "master"
    #master_config.vm.forward_port 50070, 50070
  #end

end
