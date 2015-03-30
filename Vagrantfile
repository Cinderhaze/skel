########
# Really great post, should pull in it's grab_repos script..
# https://www.devmynd.com/blog/2014-2-why-aren-t-you-using-vagrant

Vagrant.configure("2") do |config|
#  config.vm.box = "hashicorp/precise64"
  config.vm.box = "ubuntu/trusty64"
  config.vm.network :forwarded_port, host: 4567, guest:80

#  config.vm.synced_folder ".", "/home/vagrant/my-project", :nfs => true
  
  config.vm.provision "shell", inline: "apt-get update"
  config.vm.provision "shell", inline: "apt-get -y install ruby-dev git-core"
  config.vm.provision "shell", inline: "gem install librarian-puppet"
  config.vm.provision "shell", inline: "cp /vagrant/repo/Puppetfile /tmp"
  config.vm.provision "shell", inline: "cd /tmp && librarian-puppet install --verbose"

  
  # Figure out the 'right' place to put my modules so I can continually use puppet
  config.vm.provision "puppet" do |puppet|
    puppet.temp_dir = "/tmp"
    puppet.options = ['--modulepath=/tmp/modules']
  end
end
