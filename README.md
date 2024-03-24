# tor-simple

tor + pluggable transports

## Tags

* `ubuntu_rolling_*_tor_*_obfs4proxy_*_webtunnel_*_snowflake_*` (The `ubuntu:rolling` tag points to the latest release (regardless of LTS status).)
* `ubuntu_lts_*_tor_*_obfs4proxy_*` (The `ubuntu:latest` tag points to the "latest LTS", since that's the version recommended for general use.)

## Volume bindings

* `/var/log/tor` (contains `notices.log` file)
* `/usr/local/etc/tor` or `/etc/tor` (contains `torrc` file)
* `/var/lib/tor` (tor working directory, contains `cached-certs`, `cached-descriptors`, `cached-descriptors.new`, `cached-microdesc-consensus`, `cached-microdescs`, `cached-microdescs.new`, `keys`, `lock`, `pt_state`, `state`)

## See also

* https://hub.docker.com/_/ubuntu
* https://git.torproject.org
* https://gitlab.com/yawning/obfs4
* https://github.com/osminogin/docker-tor-simple
