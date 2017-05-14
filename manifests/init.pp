class webmin (
  String  $repo_ensure     = $webmin::params::repo_ensure,
  Boolean $repo_manage     = $webmin::params::repo_manage,
  Boolean $package_manage  = $webmin::params::package_manage,
  String  $package_ensure  = $webmin::params::package_ensure,
  String  $package_name    = $webmin::params::package_name,
  Array[String]
          $ssl_dependencies= $webmin::params::ssl_dependencies,
  Stdlib::Absolutepath
          $config_file     = $webmin::params::config_file,
  Boolean $service_enable  = $webmin::params::service_enable,
  Enum[stopped, running]
          $service_ensure  = $webmin::params::service_ensure,
  Boolean $service_manage  = $webmin::params::service_manage,
  String  $service_name    = $webmin::params::service_name,
  Boolean $firewall_manage = $webmin::params::firewall_manage,

  Integer $service_port    = $webmin::params::service_port,
  Boolean $ssl_enable      = $webmin::params::ssl_enable,
  Boolean $ssl_reject_ssl2 = $webmin::params::ssl_reject_ssl2,
  Boolean $ssl_reject_ssl3 = $webmin::params::ssl_reject_ssl3,
  Boolean $ssl_reject_tls1 = $webmin::params::ssl_reject_tls1,
  Boolean $ssl_reject_tls11= $webmin::params::ssl_reject_tls11,
  Boolean $ssl_reject_tls12= $webmin::params::ssl_reject_tls12,
  Boolean $ssl_redirect    = $webmin::params::ssl_redirect,
  Stdlib::Absolutepath
          $ssl_keyfile     = $webmin::params::ssl_keyfile,
  Stdlib::Absolutepath
          $ssl_certfile    = $webmin::params::ssl_certfile,
  Stdlib::Absolutepath
          $ssl_chainfile   = $webmin::params::ssl_chainfile,
  Array[String]
          $allowed_networks= $webmin::params::allowed_networks,
  ) inherits webmin::params {

  if ($package_ensure in [ 'absent', 'purged' ]) {
    class { "${module_name}::install": }
  } else {
    anchor { "${module_name}::begin": }
    -> class { "${module_name}::repo": }
    -> class { "${module_name}::install": }
    -> class { "${module_name}::config": }
    ~> class { "${module_name}::service": }
    -> class { "${module_name}::firewall": }
    -> anchor { "${module_name}::end": }
  }
}
