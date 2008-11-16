# manifests/init.pp

class silc {
    case $operatingsystem {
        openbsd: { include silc::openbsd }
        default: { include silc::base }
    }
}

class silc::base {
    package{'silc-server':
        ensure => present,
    }

    file{
        '/etc/silcd/silcd.conf':
            source => [ "puppet://$server/files/silc/server/${fqdn}/silcd.conf",
                        "puppet://$server/files/silc/server/silcd.conf",
                        "puppet://$server/silc/server/silcd.conf" ],
            notify => Service['silc-server'],
            require => Package['silc-server'],
            owner => silc, group => silc, mode => 0600;
        '/etc/silcd/silcalgs.conf':
            source => [ "puppet://$server/files/silc/server/${fqdn}/silcalgs.conf",
                        "puppet://$server/files/silc/server/silcalgs.conf",
                        "puppet://$server/silc/server/silcalgs.conf" ],
            notify => Service['silc-server'],
            require => Package['silc-server'],
            owner => silc, group => silc, mode => 0600;
    }

    service{'silc-server':
        enable => true,
        ensure => running,
        hasstatus => true,
        require => Package['silc-server'],
    }
}

class silc::openbsd inherits silc::base {
    File['/etc/silcd/silcd.conf']{
        owner => '_silc',
        group => '_silc',
    }
    File['/etc/silcd/silcalgs.conf']{
        owner => '_silc',
        group => '_silc',
    }

    Service['silc-server']{
        restart => '/bin/kill -HUP `/bin/cat /var/run/silcd.pid`',
        stop => '/bin/kill `/bin/cat /var/run/silcd.pid`',
        start => '/usr/local/sbin/silcd',
        hasstatus => false,
    }
}
