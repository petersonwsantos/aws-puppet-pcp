class profile::puppetlabs_dev {
		
	exec { 'r10k':
	  command  =>  '/opt/puppetlabs/puppet/bin/gem install --no-ri --no-rdoc r10k',
	  path     => ['/opt/puppetlabs/puppet/bin/',],
	}

	file { 'file_install_puppet_repo.bash':
	  path	=> '/scripts/install_puppet_repo.bash' ,		
	  ensure => 'present',
	  source => [ "puppet:///modules/profiles/install_puppet_repo.bash"],
	  group   => 'root',
	  mode    => '0700',
	  owner   => 'root',
	}

	exec { 'exec_install_puppet_repo.bash':
	  command  => '/bin/bash /scripts/install_puppet_repo.bash',
      path     => '/usr/bin:/usr/sbin:/bin',
	}

	file { 'puppet_repo_dev_push.bash':
	  path	=> '/scripts/puppet_repo_dev_push.bash' ,		
	  ensure => 'present',
	  source => [ "puppet:///modules/profiles/puppet_repo_dev_push.bash"],
	  group   => 'root',
	  mode    => '0700',
	  owner   => 'root',
	}
    
	Exec['r10k'] -> File['file_install_puppet_repo.bash']  -> Exec['exec_install_puppet_repo.bash']

}
