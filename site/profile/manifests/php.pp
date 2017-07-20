class profile::php {

  $packages = [
    "php",
    "php-mysql"
  ]

  package { $packages:
    ensure => present,
  }
}