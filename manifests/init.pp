class silc {
  include silc::client
  case $operatingsystem {
    openbsd: { include silc::openbsd }
    default: { include silc::base }
  }

  if $use_nagios {
    include silc::nagios
  }

  if $use_shorewall {
    include shorewall::rules::silcd
  }
}
