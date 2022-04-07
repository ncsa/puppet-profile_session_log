# @summary Setup rsyslog to forward tlog data to remote syslog server
#
# @param forward_protocol
#   Protocol to use to forward tlog messages to rsyslog server. Valid options are 'relp-tls' and 'tcp-tls'
#
# @param remote_syslog_server
#   Hostname of the remote syslog server to forward to
#
# @param remote_syslog_server_port
#   Port number of the remote syslog server to forward to
#
# # TODO rem this
# @param required_pkgs
#   List of packages required to forward tlog data over rsyslog
#
# @example
#   include profile_session_log::rsyslog
class profile_session_log::rsyslog (
  String        $forward_protocol,
  String        $remote_syslog_server,
  Integer       $remote_syslog_server_port,
  Array[String] $required_pkgs,
) {

  $enabled = lookup("${module_name}::enable_session_log", Boolean)

  if ($enabled) {
    $ensure_parm = 'present'

    $packages_defaults = {
    }

    if ($forward_protocol == 'relp-tls') {
      $required_pkgs = [ 'rsyslog-openssl' ]
    } elsif ($forward_protocol == 'tcp-tls') {
      $required_pkgs = [ 'rsyslog-gnutls' ]
    } else {
      fail("Invalid option given for forward_protocol: ${forward_protocol}")
    }

    ensure_packages( $required_pkgs, $packages_defaults )

  } else {
    $ensure_parm = 'absent'
  }

  # TODO this is the preferred method, but only for hosts that are not on EUS
  # either have it branch here and use two diff templates, or have 1 template
  # and do the differences in configs in the template
  #file { '/etc/rsyslog.d/10-tlog-forward-relp-tls.conf':
  #  ensure  => $ensure_parm,
  #  content => epp( "${module_name}/10-tlog-forward-relp-tls.conf.epp" ),
  #  owner   => 'root',
  #  group   => 'root',
  #  mode    => '0644',
  #  notify  => Service['rsyslog'],
  #}

  # TODO make this a single template
  #file { '/etc/rsyslog.d/10-tlog-forward-tcp-tls.conf':
  #  ensure  => $ensure_parm,
  #  content => epp( "${module_name}/10-tlog-forward-tcp-tls.conf.epp" ),
  #  owner   => 'root',
  #  group   => 'root',
  #  mode    => '0644',
  #  notify  => Service['rsyslog'],
  #}

}
