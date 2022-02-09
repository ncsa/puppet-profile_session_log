# @summary Setup rsyslog to forward tlog data to remote syslog server
#
# @param remote_syslog_server
#   Hostname of the remote syslog server to forward to
#
# @param remote_syslog_server_port
#   Port number of the remote syslog server to forward to
#
# @example
#   include profile_session_log::rsyslog
class profile_session_log::rsyslog (
  String $remote_syslog_server,
  Integer $remote_syslog_server_port,
) {

  $enabled = lookup("${module_name}::enable_session_log", Boolean)

  if ($enabled) {
    $ensure_parm = 'present'
  } else {
    $ensure_parm = 'absent'
  }

  file { '/etc/rsyslog.d/10-tlog-forward.conf':
    ensure  => $ensure_parm,
    content => epp( "${module_name}/10-tlog-forward.conf.epp" ),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['rsyslog'],
    #require => Package['unbound'], #TODO make this require, can it take an array of packages?
  }

}
