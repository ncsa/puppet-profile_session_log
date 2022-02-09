# @summary Install the base packages needed for tlog to function
#
# @parm required_pkgs
#   Base packages required for tlog to work
#
# @example
#   include profile_session_log::install
class profile_session_log::install (
  Array[ String ] $required_pkgs,
) {

  $packages_defaults = {
  }
  ensure_packages( $required_pkgs, $packages_defaults )

}
