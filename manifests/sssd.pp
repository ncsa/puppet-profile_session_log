# @summary Configure sssd component of tlog
#
# @param exclude_users
#   Array of users to exclude from session logging (root is automatically excluded)
#   This param only takes effect if both profile_session_log::sssd::users and profile_session_log::sssd::groups is empty
#
# @param groups
#   Array of groups who will be session logged
#
# @param users
#   Array of users who will be session logged
#
# @example
#   include profile_session_log::sssd
class profile_session_log::sssd (
  Array[String] $exclude_users,
  Array[String] $groups,
  Array[String] $users,
) {
  if ($profile_session_log::enable) {
    $ensure_parm = 'present'
  } else {
    $ensure_parm = 'absent'
  }

  if (! $exclude_users.empty and ( ! $groups.empty or ! $users.empty) ) {
    $notify_text = 'exclude_users is ignored since either groups or users is set'
    notify { $notify_text:
      loglevel => 'warning',
      withpath => true,
    }
  }

  $sssd_config_hash = {
    'exclude_users' => join($exclude_users, ', '),
    'groups'        => join($groups, ', '),
    'users'         => join($users, ', '),
  }

  file { '/etc/sssd/conf.d/sssd-session-recording.conf':
    ensure  => $ensure_parm,
    content => epp( "${module_name}/sssd-session-recording.conf.epp", $sssd_config_hash ),
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    notify  => Service['sssd'],
  }
}
