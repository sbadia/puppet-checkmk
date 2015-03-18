# Check_mk params
#
class checkmk::params {

  case $::osfamily {
    'Debian': {
      case $::operatingsystem {
        'Ubuntu': {
          $monitoring_packages = ['nagios-plugins']
        }
        default: {
          $monitoring_packages = ['monitoring-plugins']
        }
      }
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: \
${::operatingsystem}, module ${module_name} only support osfamily \
Debian")
    }
  }
}
