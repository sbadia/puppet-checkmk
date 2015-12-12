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

  include ::checkmk::params

  package {['check-mk-server','check-mk-multisite',
  'check-mk-livestatus','nagios3-core','pnp4nagios']:
    ensure => installed,
  }

  package { $::checkmk::params::monitoring_packages:
    ensure => installed,
  }

  # https://www.mail-archive.com/checkmk-en%40lists.mathias-kettner.de/msg09056.html
  #
  # sudo /etc/init.d/nagios3 stop
  # sudo dpkg-statoverride --update --add nagios www-data 2710 /var/lib/nagios3/rw
  # sudo dpkg-statoverride --update --add nagios nagios 751 /var/lib/nagios3
  # sudo /etc/init.d/nagios3 start

  checkmk::check{['apt','bird','puppet','apache_status',
  'check_dns','check_mail','check_smtp','logins',
  'nginx_status']:}


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
