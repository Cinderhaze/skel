# skel
Skeleton project with Vagrantfile, Puppetfile, in which I can build other projects


Steps to get set up

git clone https://github.com/Cinderhaze/skel.git

cd skel/

vagrant up --provider virtualbox

vagrant ssh    #to connect to your instance

vagrant destroy   # to clean up your instance



Modify repo/Puppetfile to specify which puppet modules you wish to have installed.
Modify manifests/default.pp to specify your specific puppet config.


NOTE - If you are on windows and using PuTTY, you'll need to follow the steps here - https://github.com/Varying-Vagrant-Vagrants/VVV/wiki/Connect-to-Your-Vagrant-Virtual-Machine-with-PuTTY

TODO
Put puppet modules in a proper location like /vagrant/modules
Put an example hello world project/repo in place
