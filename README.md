# profile_session_log

![pdk-validate](https://github.com/ncsa/puppet-profile_session_log/workflows/pdk-validate/badge.svg)
![yamllint](https://github.com/ncsa/puppet-profile_session_log/workflows/yamllint/badge.svg)

NCSA Common Puppet Profiles - Configure terminal session logging (tlog)

## Description

Installs and configures tlog for terminal session recording. tlog data is forwarded to a remote rsyslog server.

## Usage

This module creates a new rsyslog ruleset named `terminal_session_log`. In order to make use of this module you need to setup rsyslog so that it calls the `terminal_session_log` ruleset (typically you want to call it as the very first action in your rules). Our existing rsyslog module doesn't have the ability to inject rules from another module, so if you are configuring rsyslog via [ncsa/profile_rsyslog](https://github.com/ncsa/puppet-profile_rsyslog) you need to make some edits to your hiera.

First you need to override your config for `profile_rsyslog::config_rulesets::localhost_messages:` so that you call the new rule. Putting the `terminal_session_log` ruleset at the top would look like this:

```yaml
profile_rsyslog::config_rulesets:
  localhost_messages:
    rules:
      - call: 'terminal_session_log'
#... rest of rules omitted ...
```

If you are using `profile_session_log::rsyslog::forward_protocol: "relp-tls"` you need to make one additional change, which is to override `profile_rsyslog::config_modules:`. Specifically you need to edit the config when loading the `omrelp` module so that is uses `tls.tlslib="openssl"` so traffic can be encrypted.

```yaml
profile_rsyslog::config_modules:
  omrelp:
    config:
      tls.tlslib: "openssl"
#... rest of config omitted ...
```

## Reference

See also: [REFERENCE.md](REFERENCE.md)
