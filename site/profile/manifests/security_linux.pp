class profile::security_linux {
  # selinux 
  class { selinux: mode => 'disabled', type => 'targeted', }	
  service { 'sshd': ensure   => 'running', enable => 'true' }
  # serviço do firewall
  #service { 'firewalld': ensure   => 'running', enable => 'true' }
  # firewall ssh  
  #firewall { '1 allow ssh':    chain => 'IN_public_allow', state => ['NEW'], dport => '22'   , proto   => 'tcp', action => 'accept', }  
}
