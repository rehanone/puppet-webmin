class webmin::install () inherits webmin {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  ensure_packages([$webmin::ssl_dependencies], { ensure => present })

  if $webmin::package_manage {
    package { $webmin::package_name:
      ensure => $webmin::package_ensure,
    }
  }
}
