# Install a checkmk check
#
define checkmk::check() {

  $path='/usr/share/check_mk/checks'

  exec {"mkdir-${path}-${name}":
    command => "/bin/mkdir -p ${path}",
    unless  => "/usr/bin/test -d ${path}",
  }

  file { "${path}/${name}":
    owner   => root,
    group   => root,
    mode    => '0755',
    source  => "puppet:///modules/checkmk/checks/${name}",
    require => [
      Package['check-mk-server'],
      Exec["mkdir-${path}-${name}"]
    ],
  }

} # define
