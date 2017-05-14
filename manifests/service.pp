class webmin::service () inherits webmin {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $webmin::service_manage {
    case $::facts[operatingsystem] {
      'CentOS': {
        service { $webmin::service_name:
          ensure    => $webmin::service_ensure,
          enable    => $webmin::service_enable,
          name      => $webmin::service_name,
          provider  => 'redhat',
          subscribe => Class["${module_name}::config"],
        }
      }
      default: {
        service { $webmin::service_name:
          ensure    => $webmin::service_ensure,
          enable    => $webmin::service_enable,
          name      => $webmin::service_name,
          provider  => $::service_provider,
          subscribe => Class["${module_name}::config"],
        }
      }
    }
  }
}