class silc::base {
  package{'silc-server':
    ensure => present,
  }

  file{
    '/etc/silcd/silcd.conf':
      source => [ "puppet:///modules/site-silc/server/${fqdn}/silcd.conf",
                  "puppet:///modules/site-silc/server/modules/silcd.conf",
                  "puppet:///modules/silc/server/modules/silcd.conf" ],
      notify => Service['silc-server'],
      require => Package['silc-server'],
      owner => silc, group => silc, mode => 0600;
    '/etc/silcd/silcalgs.conf':
      source => [ "puppet:///modules/site-silc/server/${fqdn}/silcalgs.conf",
                  "puppet:///modules/site-silc/server/modules/silcalgs.conf",
                  "puppet:///modules/silc/server/modules/silcalgs.conf" ],
      notify => Service['silc-server'],
      require => Package['silc-server'],
      owner => silc, group => silc, mode => 0600;
    '/etc/silcd/motd.txt':
      source => [ "puppet:///modules/site-silc/server/${fqdn}/motd.txt",
                  "puppet:///modules/site-silc/server/motd.txt",
                  "puppet:///modules/silc/server/motd.txt" ],
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
