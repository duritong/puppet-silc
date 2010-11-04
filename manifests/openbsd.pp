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
