class webmin::params {
  $repo_ensure     = present
  $repo_manage     = true
  $package_ensure  = 'latest'
  $package_name    = 'webmin'
  $ssl_dependencies= $::facts[osfamily] ? {
    'RedHat'    => ['perl-Net-SSLeay'],
    'Debian'    => ['libnet-ssleay-perl'],
    'Archlinux' => ['perl-net-ssleay'],
    default     => [],
  }
  $config_file     = '/etc/webmin/miniserv.conf'
  $service_enable  = true
  $service_ensure  = 'running'
  $service_manage  = true
  $service_name    = 'webmin'
  $allowed_networks= []
  $firewall_manage = false

  $service_port    = 10000
  $ssl_enable      = true
  $ssl_keyfile     = '/etc/webmin/miniserv.pem'
  $ssl_certfile    = '/etc/webmin/miniserv.cert'
  $ssl_chainfile   = '/etc/webmin/extracas.chain'
  $ssl_reject_ssl2 = true
  $ssl_reject_ssl3 = true
  $ssl_reject_tls1 = true
  $ssl_reject_tls11= true
  $ssl_reject_tls12= false
  $ssl_redirect    = true
  $gui_theme       = 'authentic-theme'
}
