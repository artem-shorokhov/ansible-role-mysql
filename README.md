# Vagrant lab with MySQL Ansible role

## Notable commands

- `vagrant up` - set up Vagrant lab
- `vagrant ssh ansible` - login into Ansible server
- `ansible -m ping all` - test connection pinging target server
- `ansible-playbook /vagrant/playbook.yml` - set up MySQL on target server with Ansible MySQL role
