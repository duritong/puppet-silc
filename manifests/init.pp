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
