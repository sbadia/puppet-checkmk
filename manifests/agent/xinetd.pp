# == Class checkmk::agent::xinetd
#
# Install and configure Check_mk agent using xinetd transport
#
# === Parameters
#
# [*server*]
#   (optional) The checkmk agent command.
#   default: '/usr/bin/check_mk_agent'
#
# [*only_from*]
#   (optional) Restrict checks from this IP address
#   default: Array ['127.0.0.1']
#
# [*port*]
#   (optional) The xinetd tcp port
#   default: '6556'
#
# [*user*]
#   (optional) The user which run xinetd checkmk service
#   default: 'root'
#
# [*protocol*]
#   (optional) Protocol for xinetd checkmk service
#   default: 'tcp'
#
# [*flags*]
#   (optional) Flags for xinetd checkmk service
#   default: undef
#
# [*auto_add*]
#   (optional) Register a exported exec resources to automatically
#   refresh server configuration when a client is added. This functionality
#   require exported resources correctly configured.
#   default: false
#
class checkmk::agent::xinetd(
  $server    = '/usr/bin/check_mk_agent',
  $only_from = ['127.0.0.1'],
  $port      = '6556',
  $user      = 'root',
  $protocol  = 'tcp',
  $flags     = undef,
  $auto_add  = false,
) {

  include '::checkmk::agent'

  validate_absolute_path($server)
  validate_array($only_from)
  validate_re($port, '^\d+$', 'port is not a valid port')
  validate_string($user)
  validate_string($protocol)
  validate_string($flags)

  $check_only_from = join($only_from, ' ')

  package {'xinetd':
    ensure => installed,
  }

  # the client runs from xinetd enable it and subscribe
  #   it to the check_mk config
  service { 'xinetd':
    ensure     => running,
    enable     => true,
    hasrestart => false,
    status     => '/usr/bin/pgrep xinetd',
    subscribe  => File['/etc/xinetd.d/check_mk'],
    require    => Package['xinetd'],
  }

  # template restricts check_mk access to the only_from param
  file { '/etc/xinetd.d/check_mk':
    ensure  => file,
    content => template('checkmk/check_mk_agent_xinetd.erb'),
    mode    => '0644',
    owner   => root,
    group   => root,
    require => Package['check-mk-agent'],
  }

  if $auto_add {
    include '::checkmk::client'
  }
}
