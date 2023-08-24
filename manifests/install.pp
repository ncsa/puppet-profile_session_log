# @summary Install the base packages needed for tlog to function
#
# @example
#   include profile_session_log::install
class profile_session_log::install {
  if ($profile_session_log::enable) {
    ensure_packages( $profile_session_log::required_pkgs )
  }
}
