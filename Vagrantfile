# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/precise64"
  config.vm.hostname = "ubuntu"
  config.vm.network "private_network", type: "dhcp"
  config.vm.provision :shell, path: "bootstrap.sh"

  # Uncomment the line bellow if you want NFS (eg: You're on a Mac)
  # config.vm.synced_folder '.', '/vagrant', type: 'nfs' 

  # FIX annoying message "stdin is not a tty" on Ubuntu
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'" 

end
