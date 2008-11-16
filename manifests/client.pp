# manifests/client.pp

class silc::client {
    package{'silc-client':
        ensure => present,
    }
}
