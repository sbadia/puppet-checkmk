# == Class checkmk::agent::logwatch
#
# Install and configure Check_mk agent logwatch plugin
#
# === Parameters
#
# [*logwatch_conf*]
#   (optional) Override logwatch configuration template.
#   default: undef
#
# [*sata_reset_log_check*]
#   (optional) Enable sata_reset_log_check logwatch check
#   default: true
#
class checkmk::agent::logwatch(
  $logwatch_conf        = undef,
  $sata_reset_log_check = true,
) {

  package {'check-mk-agent-logwatch':
    ensure => installed,
  }

  if $logwatch_conf != undef {
    $logwatch_content = $logwatch_conf
  } else {
    $logwatch_content = template('checkmk/logwatch.cfg.erb')
  }

  file { '/etc/check_mk/logwatch.cfg':
    ensure  => file,
    content => $logwatch_content,
    mode    => '0644',
    owner   => root,
    group   => root,
    require => Package['check-mk-agent-logwatch'],
  }

}
