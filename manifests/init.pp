# @summary Install and configure tlog
#
# @parm enable_session_log
#   Enables or disabled the logging of sessions
#
# @example
#   include profile_session_log
class profile_session_log (
  Boolean $enable_session_log,
) {
  include ::profile_session_log::install
  include ::profile_session_log::sssd
}
