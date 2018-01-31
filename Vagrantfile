BOX    = "bento/centos-7.4"
           
HOST   = { :box => BOX,
           :hostname => "centos",
           :ip => "192.168.68.10" }
           
Vagrant.configure("2") do |config|
  
  config.vm.define HOST[:hostname] do |host|
  
    host.vm.box = HOST[:box]
    host.vm.hostname = HOST[:hostname]
    host.vm.network "private_network", ip: HOST[:ip]
    
  end
  config.vm.provision "ansible_local" do |ansible|
    ansible.provisioning_path = "/vagrant"
    ansible.inventory_path = "hosts"
    ansible.playbook = "playbook.yml"
    ansible.limit = "all"
  end
end
