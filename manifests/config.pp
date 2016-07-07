class webmin::config () inherits webmin {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  $ssl = $webmin::ssl_enable ? {
    true => '1',
    default => undef,
  }

  $os_family = $::facts[osfamily]

  case $os_family {
    'RedHat', 'Debian': {

      # Manage service port
      $augeas_service_port = [ "set port ${webmin::service_port}" ]

      # Manage service bind ip
      if ( $webmin::service_ip != undef ) {
        $augeas_service_ip = [
          'rm listen',
          "set bind ${webmin::service_ip}",
        ]
      } else {
        $augeas_service_ip = [
          "set listen ${webmin::service_port}",
          'rm bind',
        ]
      }

      # Manage ssl
      if $webmin::ssl_enable {
        $augeas_ssl = [ 'set ssl 1' ]
        $augeas_ssl_key = [ "set keyfile ${webmin::ssl_keyfile}" ]
        $augeas_ssl_cert = [ "set certfile ${webmin::ssl_certfile}" ]
        $augeas_ssl_chain = [ "set extracas ${webmin::ssl_chainfile}" ]
      } else {
        $augeas_ssl = [ 'rm ssl' ]
        $augeas_ssl_key = [ 'rm keyfile' ]
        $augeas_ssl_cert = [ 'rm certfile' ]
        $augeas_ssl_chain = [ 'rm extracas' ]
      }
      $ssl_changes = $augeas_ssl + $augeas_ssl_key + $augeas_ssl_cert + $augeas_ssl_chain

      # Manage allowed networks
      if ( $webmin::allowed_networks != undef ) {
        $allowed_networks_str= join($webmin::allowed_networks, ' ')
        $augeas_allowed_networks = [ "set allow '${allowed_networks_str}'" ]
      } else {
        $augeas_allowed_networks = [ 'rm allow' ]
      }

      # Aggregate all changes in one array for augeas
      $augeas_changes = $augeas_service_port + $augeas_service_ip + $ssl_changes + $augeas_allowed_networks
      augeas { 'webmin_miniserv_augeas_changes':
        context => '/files/etc/webmin/miniserv.conf',
        changes => $augeas_changes,
        notify  => Class["${module_name}::service"],
      }
    }
    default: { warning("Not applying webmin config for ${os_family}, make sure Augeas provider is supported on ${os_family}") }
  }
}
