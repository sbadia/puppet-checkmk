# == Class checkmk::agent::ssh
#
# Install and configure Check_mk agent using ssh transport
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
# [*user*]
#   (optional) The user which run xinetd checkmk service
#   default: 'check_mk_agent'
#
# [*ssh_pub_key*]
#   (required) The SSH public key needed for auth
#   default: ''
#
# [*auto_add*]
#   (optional) Register a exported exec resources to automatically
#   refresh server configuration when a client is added. This functionality
#   require exported resources correctly configured.
#   default: false
#
class checkmk::agent::ssh(
  $server      = '/usr/bin/check_mk_agent',
  $only_from   = ['127.0.0.1'],
  $user        = 'check_mk_agent',
  $ssh_pub_key = '',
  $auto_add    = false,
) {

  include '::checkmk::agent'

  validate_absolute_path($server)
  validate_string($user)
  validate_array($only_from)

  $check_only_from = join($only_from, ',')

  user {$user:
    ensure     => present,
    system     => true,
    shell      => '/bin/sh',
    managehome => true,
    home       => '/var/lib/check_mk_agent',
    comment    => 'Check_mk Agent',
    require    => Package['check-mk-agent'],
  }

  sudo::conf {$user:
    priority => 10,
    content  => "${user} ALL=NOPASSWD: ${server}",
  }

  file {
    '/var/lib/check_mk_agent/.ssh':
      ensure  => directory,
      require => User[$user];
    '/var/lib/check_mk_agent/.ssh/authorized_keys':
      owner   => $user,
      group   => $user,
      mode    => '0700',
      content => template('checkmk/check_mk_agent_ssh.erb'),
      require => File['/var/lib/check_mk_agent/.ssh'];
  }

  if $auto_add {
    include '::checkmk::client'
  }

}
