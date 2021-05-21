class webmin::repo () inherits webmin {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  $release = $::facts[operatingsystemrelease]

  if $webmin::repo_manage {
    case $::facts[os][family] {
      'RedHat': {
        require epel

        yumrepo { 'webmin':
          ensure     => $webmin::repo_ensure,
          mirrorlist => 'https://download.webmin.com/download/yum/mirrorlist',
          enabled    => true,
          gpgcheck   => true,
          gpgkey     => 'http://www.webmin.com/jcameron-key.asc',
          descr      => 'Webmin Distribution',
        }
      }
      'Debian': {
        require apt

        anchor { "${module_name}::begin_update": }
        -> class { "${module_name}::update::sources": }
        -> anchor { "${module_name}::end_update": }
      }
      'Archlinux': {}
      default: {}
    }
  }
}
