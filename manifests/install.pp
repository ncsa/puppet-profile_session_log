# @summary Install the base packages needed for tlog to function
#
# @param required_pkgs
#   Base packages required for tlog to work
#
# @example
#   include profile_session_log::install
class profile_session_log::install (
  Array[ String ] $required_pkgs,
) {

  $enabled = lookup("${module_name}::enable_session_log", Boolean)

  if ($enabled) {
    $packages_defaults = {
    }
    ensure_packages( $required_pkgs, $packages_defaults )
  }

}
