class webmin (
  $repo_ensure     = $webmin::params::repo_ensure,
  $repo_manage     = $webmin::params::repo_manage,
  $package_ensure  = $webmin::params::package_ensure,
  $package_name    = $webmin::params::package_name,
  $service_enable  = $webmin::params::service_enable,
  $service_ensure  = $webmin::params::service_ensure,
  $service_manage  = $webmin::params::service_manage,
  $service_name    = $webmin::params::service_name,
  $service_port    = $webmin::params::service_port,
  $service_ip      = $webmin::params::service_ip,
  $ssl_enable      = $webmin::params::ssl_enable,
  $ssl_keyfile     = $webmin::params::ssl_keyfile,
  $ssl_certfile    = $webmin::params::ssl_certfile,
  $ssl_chainfile   = $webmin::params::ssl_chainfile,
  $ssl_perl_wrapper= $webmin::params::ssl_perl_wrapper,
  $allowed_networks= $webmin::params::allowed_networks,
  $firewall_manage = $webmin::params::firewall_manage,
  ) inherits webmin::params {

  validate_string($repo_ensure)
  validate_bool($repo_manage)
  validate_string($package_ensure)
  validate_string($package_name)
  validate_bool($service_enable)
  validate_string($service_ensure)
  validate_bool($service_manage)
  validate_string($service_name)
  validate_integer($service_port)
  validate_bool($ssl_enable)
  validate_string($ssl_keyfile)
  validate_string($ssl_certfile)
  validate_string($ssl_chainfile)
  validate_string($ssl_perl_wrapper)

  unless $allowed_networks == undef {
    validate_array($allowed_networks)
  }

  validate_bool($firewall_manage)

  if ($package_ensure in [ 'absent', 'purged' ]) {
    class { "${module_name}::install": }
  } else {
    anchor { "${module_name}::begin": } ->
    class { "${module_name}::repo": } ->
    class { "${module_name}::install": } ->
    class { "${module_name}::config": } ~>
    class { "${module_name}::service": } ->
    class { "${module_name}::firewall": }->
    anchor { "${module_name}::end": }
  }
}
