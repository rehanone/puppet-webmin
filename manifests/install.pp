class webmin::install () inherits webmin {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if ! ($webmin::package_ensure in [ 'absent', 'purged' ]) {
    if ($webmin::ssl_enable and size($webmin::ssl_dependencies) > 0) {
      ensure_packages([$webmin::ssl_dependencies])
    }
  }

  package { $webmin::package_name:
    ensure => $webmin::package_ensure,
    alias  => 'webmin',
  }
}
