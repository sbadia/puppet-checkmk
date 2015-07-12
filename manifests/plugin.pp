# Install a checkmk plugin
#
# [*seconds*]
#   Configure a specific timing for a checkmk check.
#   Defaults to false
#
define checkmk::plugin(
  $seconds = false,
) {

  if $seconds {
    $path="/usr/lib/check_mk_agent/plugins/${seconds}"
  } else {
    $path='/usr/lib/check_mk_agent/plugins'
  }

  exec {"mkdir-${path}-${name}":
    command => "/bin/mkdir -p ${path}",
    unless  => "/usr/bin/test -d ${path}",
  }

  file { "${path}/${name}":
    owner   => root,
    group   => root,
    mode    => '0755',
    source  => "puppet:///modules/checkmk/plugins/${name}",
    require => [
      Package['check-mk-agent'],
      Exec["mkdir-${path}-${name}"]
    ],
  }

} # define
