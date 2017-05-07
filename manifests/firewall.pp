class webmin::firewall () inherits webmin {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $webmin::firewall_manage and defined('::firewall') {
    if size($webmin::allowed_networks) > 0 {
      $webmin::allowed_networks.each |$network| {
        firewall { "${webmin::service_port} Allow inbound Webmin connection on port: ${webmin::service_port} from: ${network}":
          dport  => $webmin::service_port,
          source => $network,
          proto  => tcp,
          action => accept,
        }
      }
    } else {
      firewall { "${webmin::service_port} Allow inbound Webmin connection on port: ${webmin::service_port}":
        dport  => $webmin::service_port,
        proto  => tcp,
        action => accept,
      }
    }
  }
}
