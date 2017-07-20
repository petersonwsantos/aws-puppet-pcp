class profile::mysql {


  # root mysql password
  $mysqlpw = "ironMaidem"

  $packages = [
    "mariadb-server",
    "mariadb"
  ]

  package { $packages:
    ensure => present,
  }

  service { "mariadb":
    ensure => running,
  }

  exec { "set-mysql-password":
    unless => "mysqladmin -uroot -p$mysqlpw status",
    command => "mysqladmin -uroot password $mysqlpw",
    require => Service["mariadb"],
  }
}