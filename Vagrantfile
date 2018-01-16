Vagrant.configure("2") do |config|
  
  BOX_CENTOS = "bento/centos-7.4"
  BOX_UBUNTU = "bento/ubuntu-16.04"
  SERVER     = { :box => BOX_UBUNTU, :hostname => "ansible", :ip => "192.168.68.10" }
  HOSTS      = [
    { :box => BOX_CENTOS, :hostname => "target", :ip => "192.168.68.11" }
  ]
  
  # Set up target server(s).
  HOSTS.each do |record|
    config.vm.define record[:hostname] do |host|
      host.vm.box = record[:box]
      host.vm.hostname = record[:hostname]
      host.vm.network "private_network", ip: record[:ip]
      
      # populate /etc/hosts with hostnames
      HOSTS.each do |line|
        if (line[:hostname] != record[:hostname])
          host.vm.provision "shell", inline: "echo #{line[:ip]} #{line[:hostname]} >> /etc/hosts"
        end
      end
    end
  end
  
  # Set up ansible server.
  config.vm.define SERVER[:hostname] do |host|
    
    host.vm.box = SERVER[:box]
    host.vm.hostname = SERVER[:hostname]
    host.vm.network "private_network", ip: SERVER[:ip]
    
    # Generate SSH key pair & upload to each target server.
    host.vm.provision "shell", inline: "ssh-keygen -f /home/vagrant/.ssh/id_rsa -N '' -t rsa"
    host.vm.provision "shell", inline: "apt-get update && apt-get install sshpass"
    
    HOSTS.each do |record|
	  host.vm.provision "shell", inline: "echo #{record[:ip]} #{record[:hostname]} >> /etc/hosts"
      host.vm.provision "shell" do |shell|
        shell.inline = "sshpass -p vagrant ssh-copy-id -i /home/vagrant/.ssh/id_rsa -o StrictHostKeyChecking=no vagrant@$1"
        shell.args   = record[:hostname]
      end
    end
    
    host.vm.provision "shell", inline: "cp ~/.ssh/known_hosts /home/vagrant/.ssh/known_hosts"
    host.vm.provision "shell", inline: "chown vagrant:vagrant /home/vagrant/.ssh/*"
    
    # Install Ansible.
    host.vm.provision "shell",
      inline: <<-SCRIPT
        apt-get update
        apt-get install software-properties-common
        apt-add-repository -y ppa:ansible/ansible
        apt-get update
        apt-get install -y ansible
      SCRIPT
    
    # Configure Ansible-related stuff.
    host.vm.provision "shell",
      inline: <<-SCRIPT
        mv /etc/ansible/hosts /etc/ansible/hosts.default
        ln -s /vagrant/hosts /etc/ansible/hosts
      SCRIPT
    
  end
  
end
