# == Class checkmk::server
#
# Install and configure Check_mk server
#
# === Parameters
#
# [*auto_add*]
#   (optional) Register a exported exec resources to automatically
#   refresh server configuration when a client is added. This functionality
#   require exported resources correctly configured.
#   default: false
#
class checkmk::server(
  $auto_add = false,
) {

  package { 'check-mk-server':
    ensure => installed,
  }

  checkmk::check{['apt','puppet']:}

  if $auto_add {
    # this exec statement will cause check_mk to regenerate
    # the nagios config when new nodes are added
    exec {'checkmk_refresh':
      command     => '/usr/bin/check_mk -O',
      refreshonly => true,
    }

    # in addition, each one will have a corresponding
    # exec resource, used to re-inventory changes
    Exec <<| tag == 'checkmk_inventory' |>>  -> Exec['checkmk_refresh']
  }

}
