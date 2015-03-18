# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # Box config
  config.vm.box = 'mtchavez/rails-dev'
  config.vm.box_version = '>= 0.0.3'

  # Set up network
  config.vm.network 'private_network', ip: '192.168.33.10'
  config.vm.network 'forwarded_port', guest: 5000, host: 5000
  config.vm.hostname = 'meeples-dev'

  # Sync app to VM
  config.vm.synced_folder '.', '/srv/app', type: 'nfs'

  # Virtualbox VM config
  config.vm.provider 'virtualbox' do |vb|
    vb.name = 'meeples'
    vb.memory = '4096'
    vb.cpus = 2
    opts = ['modifyvm', :id, '--natdnshostresolver1', 'on']
    vb.customize opts
  end
end
