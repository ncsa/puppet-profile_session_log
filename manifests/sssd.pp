# @summary Configure sssd component of tlog
#
# @parm users
#   Array of users who will be session logged
#
# @parm groups
#   Array of groups who will be session logged
#
# @example
#   include profile_session_log::sssd
class profile_session_log::sssd (
  Array[String] $groups,
  Array[String] $users,
) {

  $enabled = lookup("${module_name}::enable_session_log", Boolean)
  $required_pkgs = lookup("${module_name}::install::required_pkgs", Array)

  if ($enabled) {
    $ensure_parm = 'present'
  } else {
    $ensure_parm = 'absent'
  }

  $sssd_config_hash = {
    'users'   => join($users, ', '),
    'groups'  => join($groups, ', '),
  }

  file { '/etc/sssd/conf.d/sssd-session-recording.conf':
    ensure  => $ensure_parm,
    content => epp( "${module_name}/sssd-session-recording.conf.epp", $sssd_config_hash ),
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    notify  => Service['sssd'],
    require => Package[$required_pkgs],
  }

}
