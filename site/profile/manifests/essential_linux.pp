class profile::essential_linux {
	#include ::pp_essential::packages
	#include ::pp_essential::groups
	#include ::pp_essential::hosts
	#include ::pp_essential::users
	#include ::pp_essential::scripts_linux
	class { 'cron':
  		manage_package => false,
	}

}
 
