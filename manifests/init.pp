# @summary Install and configure tlog
#
# @example
#   include profile_session_log
class profile_session_log {
  include ::profile_session_log::install
  include ::profile_session_log::sssd
}
