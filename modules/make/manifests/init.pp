# == Class: make
#
# Install the make package
#
class make (
  $package_name   = 'make',
  $package_ensure = 'present'
) {

  # "package" will validate $package_ensure for us..

  package { $package_name:
    ensure => $package_ensure,
  }
}
