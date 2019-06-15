class webmin::update::ppa {

  assert_private("Use of private class ${name} by ${caller_module_name}")


  case $::facts[os][name] {
    # 'Debian': {
    #   exec { 'apt_show_versions_purge':
    #     command   => 'apt-get purge apt-show-versions',
    #     path      => ['/usr/bin', '/sbin', '/bin'],
    #     creates   => '/opt/webmin_apt_ppa_install',
    #     logoutput => 'on_failure',
    #   }
    #   -> exec { 'apt_show_versions_remove_index':
    #     command   => 'rm -rf /var/lib/apt/lists/*gz && rm -rf /etc/apt/apt.conf.d/02compress-indexes',
    #     path      => ['/usr/bin', '/sbin', '/bin'],
    #     creates   => '/opt/webmin_apt_ppa_install',
    #     logoutput => 'on_failure',
    #   }
    #   -> exec { 'apt_show_versions_update':
    #     command   => 'apt-get -o Acquire::GzipIndexes=false update',
    #     path      => ['/usr/bin', '/sbin', '/bin'],
    #     creates   => '/opt/webmin_apt_ppa_install',
    #     logoutput => 'on_failure',
    #   }
    #   -> exec { 'apt_show_versions_install':
    #     command   => 'apt-get install -y apt-show-versions',
    #     path      => ['/usr/bin', '/sbin', '/bin'],
    #     creates   => '/opt/webmin_apt_ppa_install',
    #     logoutput => 'on_failure',
    #   }
    #   -> exec { 'webmin_apt_ppa_install':
    #     command   => 'apt-get update &&  apt-get install -y unattended-upgrades software-properties-common apt-show-versions && touch /opt/webmin_apt_ppa_install',
    #     path      => ['/usr/bin', '/sbin', '/bin'],
    #     creates   => '/opt/webmin_apt_ppa_install',
    #     logoutput => 'on_failure',
    #   }
    # }
    default:{
      exec { 'apt_show_versions_purge':
        command   => 'apt-get purge apt-show-versions',
        path      => ['/usr/bin', '/sbin', '/bin'],
        creates   => '/opt/webmin_apt_ppa_install',
        logoutput => 'on_failure',
      }
      -> exec { 'apt_show_versions_remove_index':
        command   => 'rm -rf /var/lib/apt/lists/*lz4 && rm -rf /etc/apt/apt.conf.d/docker-gzip-indexes',
        path      => ['/usr/bin', '/sbin', '/bin'],
        creates   => '/opt/webmin_apt_ppa_install',
        logoutput => 'on_failure',
      }
      -> exec { 'apt_show_versions_update':
        command   => 'apt-get -o Acquire::GzipIndexes=false update',
        path      => ['/usr/bin', '/sbin', '/bin'],
        creates   => '/opt/webmin_apt_ppa_install',
        logoutput => 'on_failure',
      }
      -> exec { 'apt_show_versions_install':
        command   => 'apt-get install -y apt-show-versions',
        path      => ['/usr/bin', '/sbin', '/bin'],
        creates   => '/opt/webmin_apt_ppa_install',
        logoutput => 'on_failure',
      }
      -> exec { 'webmin_apt_ppa_install':
        command   => 'apt-get update &&  apt-get install -y unattended-upgrades software-properties-common python3-software-properties && touch /opt/webmin_apt_ppa_install',
        path      => ['/usr/bin', '/sbin', '/bin'],
        creates   => '/opt/webmin_apt_ppa_install',
        logoutput => 'on_failure',
        require   => Exec['apt_show_versions_install'],
      }
    }
  }
}
