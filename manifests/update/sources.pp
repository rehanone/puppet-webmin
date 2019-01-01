class webmin::update::sources inherits webmin {

  assert_private("Use of private class ${name} by ${caller_module_name}")

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
  -> apt::source { 'webmin_main':
    ensure   => $webmin::repo_ensure,
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
