class profile::apache {

  # install apache
  package { "httpd":
    ensure => present,
  }


  service { "httpd":
    ensure => running,
    require => Package["httpd"],
    subscribe => [
      File["/etc/apache2/mods-enabled/rewrite.load"],
      File["/etc/apache2/sites-available/vagrant_webroot"]
    ],
  }

}