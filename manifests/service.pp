class webmin::service () inherits webmin {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $webmin::service_manage {
    service { $webmin::service_name:
      ensure    => $webmin::service_ensure,
      enable    => $webmin::service_enable,
      name      => $webmin::service_name,
      subscribe => Class["${module_name}::config"],
    }
  }
}
