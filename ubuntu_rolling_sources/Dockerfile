FROM ubuntu:rolling

ARG BUILD_PLATFORM
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

# see https://git.torproject.org/

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y golang git build-essential automake libevent-dev libssl-dev zlib1g-dev libzstd-dev liblzma-dev curl libc6 libcap2 liblzma5 libseccomp2 libssl3 libsystemd0 libzstd1 zlib1g adduser lsb-base && \
    echo go version && \
    mkdir -p ~/git && \
    cd ~/git && \
    git clone https://gitlab.torproject.org/tpo/core/tor.git && \
    git clone https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/webtunnel.git && \
    git clone https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/snowflake.git && \
    git clone https://gitlab.com/yawning/obfs4.git && \
    # build tor
    cd ~/git/tor && \
    git fetch --tags && \
    torLatestTag=$(git describe --tags "$(git rev-list --tags --max-count=1)") && \
    git checkout $torLatestTag && \
    ./autogen.sh && \
    ./configure --disable-asciidoc && \
    make && \
    make install && \
    # build webtunnel
    cd ~/git/webtunnel/main/client && \
    webtunnelCommitHash=$(git rev-parse --short HEAD) && \
    go get && \
    go build && \
    cp client /usr/bin/webtunnel && \
    chmod +x /usr/bin/webtunnel && \
    # build snowflake
    cd ~/git/snowflake/client && \
    snowflakeCommitHash=$(git rev-parse --short HEAD) && \
    go get && \
    go build && \
    cp client /usr/bin/snowflake && \
    chmod +x /usr/bin/snowflake && \
    # build obfs4proxy
    cd ~/git/obfs4 && \
    git fetch --tags && \
    obfs4LatestTag=$(git describe --tags "$(git rev-list --tags --max-count=1)") && \
    git checkout $obfs4LatestTag && \
    cd ~/git/obfs4/obfs4proxy && \
    go get && \
    go build && \
    cp obfs4proxy /usr/bin/obfs4proxy && \
    chmod +x /usr/bin/obfs4proxy && \
    # add torrc file
    sed "1s/^/SocksPort 0.0.0.0:9050\n/" /usr/local/etc/tor/torrc.sample > /usr/local/etc/tor/torrc && \
    # check versions
    ubuntu_version=$(cat /etc/os-release | grep VERSION_ID | awk -F '"' '{print $2}') && \
    torLatestTag=$(echo $torLatestTag | sed 's/.*-//') && \
    obfs4LatestTag=$(echo $obfs4LatestTag | sed 's/.*-//') && \
    actualVersion="ubuntu_rolling_${ubuntu_version}_tor_${torLatestTag}_obfs4proxy_${obfs4LatestTag}_webtunnel_${webtunnelCommitHash}_snowflake_${snowflakeCommitHash}" && \
    if [ "$actualVersion" != "$VERSION" ]; then echo "Version mismatch: argument $VERSION, actual $actualVersion" && exit 1; fi && \
    # cleanup
    go clean -modcache -cache -testcache -fuzzcache && \
    rm -rf ~/go && \
    rm -rf ~/.cache && \
    apt-get remove -y golang git build-essential automake libssl-dev zlib1g-dev libzstd-dev liblzma-dev && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf ~/git

EXPOSE 9050

HEALTHCHECK --interval=60s --timeout=15s --start-period=20s \
    CMD curl -x socks5h://127.0.0.1:9050 'https://check.torproject.org/api/ip' | grep -qm1 -E '"IsTor"\s*:\s*true'

VOLUME ["/var/lib/tor"]
CMD ["tor"]
