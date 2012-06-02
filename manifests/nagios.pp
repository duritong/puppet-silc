# manifests/nagios.pp

class silc::nagios {
  $nagios_host = hiera('silc_nagios_host',$::fqdn)
  nagios::service{ "silc_${::fqdn}": check_command => "check_silc!${nagios_host}" }
}
