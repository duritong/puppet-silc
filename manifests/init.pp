class silc(
  $manage_nagios = false,
  $manage_shorewall = false,
  $nagios_host = $::fqdn
) {
  class{'silc::client':
    manage_shorewall => $manage_shorewall
  }
  case $::operatingsystem {
    openbsd: { include silc::openbsd }
    default: { include silc::base }
  }

  if $manage_nagios {
    include silc::nagios
  }

  if $manage_shorewall {
    include shorewall::rules::silcd
  }
}
