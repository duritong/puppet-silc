class silc::client {
  case $::operatingsystem {
    debian: { include silc::client::debian }
    default: { include silc::client::base }
  }

  if hiera('use_shorewall',false) {
    include shorewall::rules::out::silc
  }
}
