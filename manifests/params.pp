class webmin::params {
  $repo_ensure     = present
  $repo_manage     = true
  $package_ensure  = 'latest'
  $package_name    = 'webmin'
  $service_enable  = true
  $service_ensure  = 'running'
  $service_manage  = true
  $service_name    = 'webmin'
  $service_port    = 10000
  $service_ip      = undef
  $ssl_enable      = true
  $ssl_keyfile     = '/etc/webmin/miniserv.pem'
  $ssl_certfile    = '/etc/webmin/miniserv.cert'
  $ssl_chainfile   = '/etc/webmin/extracas.chain'
  $ssl_dependencies= $::facts[osfamily] ? {
    'RedHat'    => ['perl-Net-SSLeay'],
    'Debian'    => ['libnet-ssleay-perl'],
    'Archlinux' => ['perl-net-ssleay'],
    default     => [],
  }
  $allowed_networks= undef
  $firewall_manage = false
  $firewall_rule_id= $service_port
}
