class silc {
  include silc::client
  case $::operatingsystem {
    openbsd: { include silc::openbsd }
    default: { include silc::base }
  }

  if hiera('use_nagios',false) {
    include silc::nagios
  }

  if hiera('use_shorewall',false) {
    include shorewall::rules::silcd
  }
}
