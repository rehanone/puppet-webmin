class webmin::firewall () inherits webmin {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  $port = $webmin::service_port

  if $webmin::firewall_manage {
    if size($webmin::allowed_networks) > 0 {
      $webmin::allowed_networks.each |$network| {
        if defined('::firewall') {
          firewall { "${port} Allow WEBMIN tcp connection on port: ${port} from: ${network}":
            dport  => $port,
            source => $network,
            proto  => tcp,
            action => accept,
          }
        }

        if defined('::ferm') {
          ferm::rule { "WEBMIN - Allow inbound tcp connection on port: ${port} from: ${network}":
            chain  => 'INPUT',
            saddr  => $network,
            dport  => $port,
            proto  => tcp,
            action => 'ACCEPT',
          }
        }
      }
    } else {
      if defined('::firewall') {
        firewall { "${port} Allow WEBMIN tcp connection on port: ${port}":
          dport  => $port,
          proto  => tcp,
          action => accept,
        }
      }

      if defined('::ferm') {
        ::ferm::rule { "WEBMIN - Allow inbound tcp connection on port: ${port}":
          chain  => 'INPUT',
          dport  => "(${port})",
          proto  => tcp,
          action => 'ACCEPT',
        }
      }
    }
  }
}
