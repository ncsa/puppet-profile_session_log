# @summary Configure sssd component of tlog
#
# @example
#   include profile_session_log::sssd
class profile_session_log::sssd {

  $enabled = lookup('profile_session_log::enable_session_log', Boolean)

  if ($enabled) {
    $ensure_parm = 'present'
  } else {
    $ensure_parm = 'absent'
  }

  $sssd_config_hash = {
    'users'  => 'ben, noone',
    'groups' => '',
  }


  file { '/etc/sssd/conf.d/sssd-session-recording.conf':
    ensure  => $ensure_parm,
    #content => epp( 'profile_session_log/sssd-session-recording.conf.epp' ), #TODO rem this
    content => epp( 'profile_session_log/sssd-session-recording.conf.epp', $sssd_config_hash ),
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    notify  => Service['sssd'],
    #require => Package['unbound'], #TODO make this require, can it take an array of packages?
  }

}
