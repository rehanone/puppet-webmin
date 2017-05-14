class webmin::update::ppa {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  exec { 'webmin_apt_ppa_install':
    command   => 'apt-get update &&  apt-get install -y apt-show-versions unattended-upgrades software-properties-common python-software-properties && touch /opt/webmin_apt_ppa_install',
    path      => ['/usr/bin', '/sbin', '/bin'],
    creates   => '/opt/webmin_apt_ppa_install',
    logoutput => 'on_failure',
  }
}
