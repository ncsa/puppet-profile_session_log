# @summary Setup and configure tlog
#
# @param message
#   Message to display when tlog starts recording session
#
# @example
#   include profile_session_log::tlog
class profile_session_log::tlog (
  String $message,
) {
  if ($profile_session_log::enable) {
    $ensure_parm = 'present'
  } else {
    $ensure_parm = 'absent'
  }

  $tlog_cfg_hash = {
    'message' => $message,
  }

  file { '/etc/tlog/tlog-rec-session.conf':
    ensure  => $ensure_parm,
    content => epp( "${module_name}/tlog-rec-session.conf.epp", $tlog_cfg_hash ),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
