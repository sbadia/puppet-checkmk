# == Class checkmk::client
#
# Install and configure Check_mk (exported ressource)
#
class checkmk::client {

  # the exported exec resource
  # this will trigger a check_mk inventory of the specific node
  # whenever its config changes
  @@exec { "checkmk_inventory_${::fqdn}":
    command     => "/usr/bin/check_mk -uI ${::fqdn}",
    notify      => Exec['checkmk_refresh'],
    refreshonly => true,
    tag         => 'checkmk_inventory',
  }
}
