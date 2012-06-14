class silc::client(
  $manage_shorewall = false,
) {
  case $::operatingsystem {
    debian: { include silc::client::debian }
    default: { include silc::client::base }
  }

  if $manage_shorewall {
    include shorewall::rules::out::silc
  }
}
