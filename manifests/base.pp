class silc::base {
    package{'silc-server':
        ensure => present,
    }

    file{
        '/etc/silcd/silcd.conf':
            source => [ "puppet://$server/modules/site-silc/server/${fqdn}/silcd.conf",
                        "puppet://$server/modules/site-silc/server/modules/silcd.conf",
                        "puppet://$server/modules/silc/server/modules/silcd.conf" ],
            notify => Service['silc-server'],
            require => Package['silc-server'],
            owner => silc, group => silc, mode => 0600;
        '/etc/silcd/silcalgs.conf':
            source => [ "puppet://$server/modules/site-silc/server/${fqdn}/silcalgs.conf",
                        "puppet://$server/modules/site-silc/server/modules/silcalgs.conf",
                        "puppet://$server/modules/silc/server/modules/silcalgs.conf" ],
            notify => Service['silc-server'],
            require => Package['silc-server'],
            owner => silc, group => silc, mode => 0600;
        '/etc/silcd/motd.txt':
            source => [ "puppet://$server/modules/site-silc/server/${fqdn}/motd.txt",
                        "puppet://$server/modules/site-silc/server/motd.txt",
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
