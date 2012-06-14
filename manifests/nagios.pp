# manifests/nagios.pp

class silc::nagios {
  nagios::service{ "silc_${::fqdn}": check_command => "check_silc!${silc::nagios_host}" }
}
