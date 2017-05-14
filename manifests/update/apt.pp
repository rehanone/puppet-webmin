class webmin::update::apt {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  exec { 'webmin_apt_get_update':
    command   => 'apt-get update && touch /opt/webmin_apt_get_update',
    path      => ['/usr/bin', '/bin'],
    creates   => '/opt/webmin_apt_get_update',
    logoutput => 'on_failure',
  }
}
