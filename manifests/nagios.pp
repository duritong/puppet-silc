# manifests/nagios.pp

class silc::nagios {
  case $silc_nagios_host {
    '': { $silc_nagios_host = $fqdn }
  }
  nagios::service{ "silc_${fqdn}": check_command => "check_silc!${silc_nagios_host}" }
}
