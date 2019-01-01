class webmin::repo () inherits webmin {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  $release = $::facts[operatingsystemrelease]

  if $webmin::repo_manage {
    case $::facts[os][family] {
      'RedHat': {
        yumrepo { 'epel':
          ensure   => $webmin::repo_ensure,
          baseurl  => lookup('webmin::package_epel_url'),
          enabled  => true,
          gpgcheck => true,
          gpgkey   => lookup('webmin::package_epel_key'),
          descr    => 'EPEL Distribution',
        }
        yumrepo { 'webmin':
          ensure     => $webmin::repo_ensure,
          mirrorlist => 'http://download.webmin.com/download/yum/mirrorlist',
          enabled    => true,
          gpgcheck   => true,
          gpgkey     => 'http://www.webmin.com/jcameron-key.asc',
          descr      => 'Webmin Distribution',
        }
      }
      'Debian': {
        require apt

        case $::facts[os][release][major] {
          '18.04', '18.10': {
            anchor { "${module_name}::begin_update": }
            -> class { "${module_name}::update::ppa": }
            -> class { "${module_name}::update::sources": }
            -> class { "${module_name}::update::apt": }
            -> anchor { "${module_name}::end_update": }
          }
          default: {
            anchor { "${module_name}::begin_update": }
            -> class { "${module_name}::update::ppa": }
            -> class { "${module_name}::update::sources": }
            -> class { "${module_name}::update::apt": }
            -> anchor { "${module_name}::end_update": }
          }
        }
      }
      'Archlinux': {}
      default: {}
    }
  }
}
