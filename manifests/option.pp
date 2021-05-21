define webmin::option (
  Variant[Boolean, Integer, String, Array[String], Undef] $value,
) {

  if $value !~ Undef {

    $str_value = $value ? {
      Array   => join($value, ' '),
      true    => '1',
      false   => '',
      default => $value
    }

    $changes = $str_value ? {
      ''      => "clear \"${title}\"",
      default => "set \"${title}\" \"${str_value}\"",
    }

    augeas { "webmin-${title}":
      incl    => $webmin::config_file,
      lens    => 'Webmin.lns',
      changes => $changes,
      notify  => Class["${module_name}::service"],
    }
  }
}
