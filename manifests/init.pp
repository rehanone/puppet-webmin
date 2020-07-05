class webmin (
  String                 $repo_ensure,
  Boolean                $repo_manage,
  Boolean                $package_manage,
  String                 $package_ensure,
  String                 $package_name,
  Array[String]          $ssl_dependencies,
  Stdlib::Absolutepath   $config_file,
  Boolean                $service_enable,
  Enum[stopped, running] $service_ensure,
  Boolean                $service_manage,
  String                 $service_name,
  Boolean                $firewall_manage,

  Stdlib::Port           $service_port,
  Boolean                $ssl_enable,
  Boolean                $ssl_reject_ssl2,
  Boolean                $ssl_reject_ssl3,
  Boolean                $ssl_reject_tls1,
  Boolean                $ssl_reject_tls11,
  Boolean                $ssl_reject_tls12,
  Boolean                $ssl_redirect,
  Stdlib::Absolutepath   $ssl_keyfile,
  Stdlib::Absolutepath   $ssl_certfile,
  Stdlib::Absolutepath   $ssl_chainfile,
  Array[String]          $allowed_networks,
) {

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
