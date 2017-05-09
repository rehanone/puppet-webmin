node default {

  notify { 'enduser-before': }
  notify { 'enduser-after': }

  class { 'webmin':
    repo_manage => true,
    require     => Notify['enduser-before'],
    before      => Notify['enduser-after'],
  }
}
