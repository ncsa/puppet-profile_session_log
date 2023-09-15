# @summary Install and configure tlog
#
# @param enable
#   Enables or disabled the logging of sessions
#
# @param required_pkgs
#   Base packages required for tlog to work
#
# @example
#   include profile_session_log
class profile_session_log (
  Boolean $enable,
  Array[String] $required_pkgs,
) {
  include profile_session_log::install
  include profile_session_log::rsyslog
  include profile_session_log::sssd
  include profile_session_log::tlog
}
