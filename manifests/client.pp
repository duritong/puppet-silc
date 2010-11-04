class silc::client {
  case $operatingsystem {
    debian: { include silc::client::debian }
    default: { include silc::client::base }
  }

  if $use_shorewall {
    include shorewall::rules::out::silc
  }
}
