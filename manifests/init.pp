# manifests/init.pp

class silc {
    case $operatingsystem {
        openbsd: { include silc::openbsd }
        default: { include silc::base }
    }

    if $use_nagios {
        include silc::nagios
    }
}

class silc::base {
    package{'silc-server':
        ensure => present,
    }

    file{
        '/etc/silcd/silcd.conf':
            source => [ "puppet://$server/files/silc/server/${fqdn}/silcd.conf",
                        "puppet://$server/files/silc/server/modules/silcd.conf",
                        "puppet://$server/modules/silc/server/silcd.conf" ],
            notify => Service['silc-server'],
            require => Package['silc-server'],
            owner => silc, group => silc, mode => 0600;
        '/etc/silcd/silcalgs.conf':
            source => [ "puppet://$server/files/silc/server/${fqdn}/silcalgs.conf",
                        "puppet://$server/files/silc/server/modules/silcalgs.conf",
                        "puppet://$server/modules/silc/server/silcalgs.conf" ],
            notify => Service['silc-server'],
            require => Package['silc-server'],
            owner => silc, group => silc, mode => 0600;
        '/etc/silcd/motd.txt':
            source => [ "puppet://$server/files/silc/server/${fqdn}/motd.txt",
                        "puppet://$server/files/silc/server/motd.txt",
                        "puppet://$server/modules/silc/server/motd.txt" ],
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
        owner => '_silcd',
        group => '_silcd',
    }
    File['/etc/silcd/silcalgs.conf']{
        owner => '_silcd',
        group => '_silcd',
    }
    File['/etc/silcd/motd.txt']{
        owner => '_silcd',
        group => '_silcd',
    }

    Service['silc-server']{
        restart => '/bin/kill -HUP `/bin/cat /var/run/silcd.pid`',
        stop => '/bin/kill `/bin/cat /var/run/silcd.pid`',
        start => 'ulimit -n 1024;/usr/local/sbin/silcd',
        pattern => 'silcd',
        hasstatus => false,
    }
}
