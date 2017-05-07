
define webmin::option (
  Variant[Boolean, Integer, String, Array[String], Undef]
      $value,
) {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $value !~ Undef {

    $str_value = $value ? {
      Array   => join($value, ' '),
      true    => '1',
      false   => '',
      default => $value
    }

    $changes = $str_value ? {
      ''      => "clear \"${name}\"",
      default => "set \"${name}\" \"${str_value}\"",
    }

    augeas { "webmin-${name}":
      incl    => $webmin::config_file,
      lens    => 'Webmin.lns',
      changes => $changes,
      notify  => Class["${module_name}::service"]
    }
  }
}
