class webmin::install () inherits webmin {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if ! ($webmin::package_ensure in [ 'absent', 'held', 'installed', 'latest', 'present', 'purged' ]) {
    fail('package_ensure parameter must be one of absent, held, installed, latest, present, purged')
  }

  if ! ($webmin::package_ensure in [ 'absent', 'purged' ]) {
    if ($webmin::ssl_enable and $webmin::ssl_perl_wrapper != undef) {
      ensure_packages([$webmin::ssl_perl_wrapper])
    }
  }

  package { $webmin::package_name:
    ensure => $webmin::package_ensure,
    alias  => 'webmin',
  }
}
