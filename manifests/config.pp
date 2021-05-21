class webmin::config () inherits webmin {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  $ssl = $webmin::ssl_enable ? {
    true => '1',
    default => undef,
  }

  $os_family = $::facts[os][family]

  case $os_family {
    'RedHat', 'Debian': {

      webmin::option {
        'port':          value => $webmin::service_port;
        'ssl':           value => $webmin::ssl_enable;
        'keyfile':       value => $webmin::ssl_keyfile;
        'certfile':      value => $webmin::ssl_certfile;
        'extracas':      value => $webmin::ssl_chainfile;
        'no_ssl2':       value => $webmin::ssl_reject_ssl2;
        'no_ssl3':       value => $webmin::ssl_reject_ssl3;
        'no_tls1':       value => $webmin::ssl_reject_tls1;
        'no_tls1_1':     value => $webmin::ssl_reject_tls11;
        'no_tls1_2':     value => $webmin::ssl_reject_tls12;
        'ssl_redirect':  value => $webmin::ssl_redirect;
        'allow':         value => $webmin::allowed_networks;
      }
    }
    default: { warning("Not applying webmin config for ${os_family}, make sure Augeas provider is supported on ${os_family}") }
  }
}
