class webmin::repo () inherits webmin {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  $codename = $::facts[lsbdistcodename]

  if $webmin::repo_manage {
    case $::facts[osfamily] {
      'RedHat': {
        yumrepo { 'webmin':
          ensure     =>  $webmin::params::repo_ensure,
          mirrorlist => 'http://download.webmin.com/download/yum/mirrorlist',
          enabled    => '1',
          gpgcheck   => '1',
          gpgkey     => 'http://www.webmin.com/jcameron-key.asc',
          descr      => 'Webmin Distribution',
        }
      }
      'Ubuntu', 'Debian': {
        case $codename {
          'precise', 'trusty', 'xenial': {
            apt::source { 'webmin_mirror':
              ensure   => 'absent',
              location => 'http://webmin.mirror.somersettechsolutions.co.uk/repository',
              release  => 'sarge',
              repos    => 'contrib',
              key      => {
                'id'     => '1719003ACE3E5A41E2DE70DFD97A3AE911F63C51',
                'source' => 'http://www.webmin.com/jcameron-key.asc',
              },
              include  => {
                'src' => false,
              },
            }
            apt::source { 'webmin_main':
              ensure   =>  $webmin::params::repo_ensure,
              location => 'http://download.webmin.com/download/repository',
              release  => 'sarge',
              repos    => 'contrib',
              key      => {
                'id'     => '1719003ACE3E5A41E2DE70DFD97A3AE911F63C51',
                'source' => 'http://www.webmin.com/jcameron-key.asc',
              },
              include  => {
                'src' => false,
              },
            }
          }
          default: { warning("${codename} is not a supported platform") }
        }
      }
      'Archlinux': { }
      default: { }
    }
  }
}
