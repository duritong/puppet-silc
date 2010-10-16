# manifests/client.pp

class silc::client {
  case $operatingsystem {
    openbsd: { include silc::client::openbsd }
    default: { include silc::client::base }
  }
}
