class role { 

}

class role::essential_linux   inherits role {
	include profile::essential_linux
	include profile::security_linux
}

class role::puppetlabs_repo_dev  inherits role::essential_linux   { 
    include profile::puppetlabs_dev
}

class role::web_hosting_pack1 inherits role::essential_linux    { 
	include profile::apache
	include profile::php
}

class role::web_hosting_pack2 inherits role::essential_linux    { 
	include profile::apache
	include profile::php
	include profile::mysql
}	

