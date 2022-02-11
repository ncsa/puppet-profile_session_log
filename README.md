# profile_session_log

![pdk-validate](https://github.com/ncsa/puppet-profile_session_log/workflows/pdk-validate/badge.svg)
![yamllint](https://github.com/ncsa/puppet-profile_session_log/workflows/yamllint/badge.svg)

NCSA Common Puppet Profiles - Configure tlog session logging

## Description

Installs and configures tlog for terminal session recording. tlog data is forwarded to a remote rsyslog server.

## Dependencies
* sssd configured
* rsyslog
* TODO flesh this out

## Usage

The goal is that no paramters are required to be set. The default paramters should work for most NCSA deployments out of the box.

But there are two sets of parameters you may desire to override.

# TODO ^^^^^

## Reference

### class profile_session_log::rsyslog (
-  String        $remote_syslog_server,
-  Integer       $remote_syslog_server_port,
-  Array[String] $required_pkgs,
### class profile_session_log::sssd (
-  Array[String] $groups,
-  Array[String] $users,
### class profile_session_log (
-  Boolean $enable_session_log,
### class profile_session_log::install (
-  Array[ String ] $required_pkgs,

See also: [REFERENCE.md](REFERENCE.md)
