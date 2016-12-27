class webmin (
  String  $repo_ensure     = $webmin::params::repo_ensure,
  Boolean $repo_manage     = $webmin::params::repo_manage,
  String  $package_ensure  = $webmin::params::package_ensure,
  String  $package_name    = $webmin::params::package_name,
  Boolean $service_enable  = $webmin::params::service_enable,
  String  $service_ensure  = $webmin::params::service_ensure,
  Boolean $service_manage  = $webmin::params::service_manage,
  String  $service_name    = $webmin::params::service_name,
  Integer $service_port    = $webmin::params::service_port,
  Optional[String]
          $service_ip      = $webmin::params::service_ip,
  Boolean $ssl_enable      = $webmin::params::ssl_enable,
  Stdlib::Absolutepath
          $ssl_keyfile     = $webmin::params::ssl_keyfile,
  Stdlib::Absolutepath
          $ssl_certfile    = $webmin::params::ssl_certfile,
  Stdlib::Absolutepath
          $ssl_chainfile   = $webmin::params::ssl_chainfile,
  Array[String]
          $ssl_dependencies= $webmin::params::ssl_dependencies,
  Optional[Array[String]]
          $allowed_networks= $webmin::params::allowed_networks,
  Boolean $firewall_manage = $webmin::params::firewall_manage,
  ) inherits webmin::params {

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
