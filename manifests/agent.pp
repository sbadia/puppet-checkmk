# == Class checkmk::agent
#
# Install and configure Check_mk agent
#
class checkmk::agent {

  package {['cron-apt','check-mk-agent']:
    ensure => installed,
  }

  checkmk::plugin{
    ['puppet','conntrack','apt',
      'smart','dmraid','mk_mysql',
      'mk_postgres','lnx_psperf']:
  }
}
