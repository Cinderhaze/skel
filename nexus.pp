# install

include 'java'

package {'upstart':
  ensure => 'present',
}

package {['build-essential']: #build tools required for rest-client gem dep
  ensure => present,
} ->
package {['rest-client', 'mime-types', 'json']:
  ensure => installed,
  provider => gem,
}


staging::deploy { 'nexus-2.11.4-01-bundle.tar.gz':
  source => '/vagrant/nexus-2.11.4-01-bundle.tar.gz',
  target => '/opt/',
  creates => '/opt/nexus-2.11.4-01/',
}
->
file { '/opt/nexus':
  ensure => 'link',
  target => '/opt/nexus-2.11.4-01',
  owner => 'nexus',
  group =>'nexus',
}
#->
#exec { [
#         '/bin/chown nexus:nexus -R /opt/nexus-2.11.4-01/',
#       ]:
#  refreshonly => true,
#}

user {'nexus':
  ensure => 'present',
  groups => 'nexus',
}
group {'nexus':
  ensure => 'present',
}
# configure
# /opt/nexus/conf/nexus.properties

file { ['/opt/nexus-2.11.4-01','/opt/sonatype-work']:
  ensure => 'directory',
  recurse => true,
  owner => 'nexus',
  group =>'nexus',
  checksum => 'none',
  require => File['/opt/nexus'],
#  before => Service['nexus'],
}

# service
#$cmd = "exec su -s /bin/sh -c 'exec \"\$0\" \"$@\"' nexus -- /opt/nexus/bin/nexus " 
#$cmd = "exec su -s /bin/sh -c 'exec \"$0\" \"$@\"' nexus -- /opt/nexus/bin/nexus " 
$cmd = '/opt/nexus/bin/nexus'
service{ 'nexus':
  ensure => 'running',
  enable => true,
  provider => 'base',
  start => "${cmd} start",
  restart => "${cmd} restart",
  status => "${cmd} status | /bin/grep -v not",
  stop => "${cmd} stop",
}

file{'/etc/init.d/nexus':
  ensure => 'link',
  target => '/opt/nexus/bin/nexus',
}

file{'/etc/puppet/nexus_rest.conf':
  ensure => 'link',
  target => '/vagrant/nexus_rest.conf',
}




