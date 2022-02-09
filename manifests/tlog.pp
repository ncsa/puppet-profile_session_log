# @summary Setup and configure tlog
#
# @example
#   include profile_session_log::tlog
class profile_session_log::tlog {

  $enabled = lookup("${module_name}::enable_session_log", Boolean)

  if ($enabled) {
    $ensure_parm = 'present'
  } else {
    $ensure_parm = 'absent'
  }

  file { '/etc/tlog/tlog-rec-session.conf':
    ensure => $ensure_parm,
    source => "puppet:///modules/${module_name}/tlog-rec-session.conf",
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
    #require => Package['unbound'], #TODO make this require, can it take an array of packages?
  }

}
