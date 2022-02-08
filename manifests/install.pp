# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# #TODO add param for $required_pkgs
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
