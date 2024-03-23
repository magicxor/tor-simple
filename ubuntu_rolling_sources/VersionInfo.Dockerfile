FROM ubuntu:rolling

# see https://git.torproject.org/

RUN apt-get update && \
    apt-get install -y git && \
    mkdir -p ~/git && \
    cd ~/git && \
    git clone https://gitlab.torproject.org/tpo/core/tor.git && \
    cd ~/git/tor && \
    git fetch --tags && \
    torLatestTag=$(git describe --tags "$(git rev-list --tags --max-count=1)") && \
    cd ~/git && \
    git clone https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/webtunnel.git && \
    cd ~/git/webtunnel/main/client && \
    webtunnelCommitHash=$(git rev-parse --short HEAD) && \
    cd ~/git && \
    git clone https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/snowflake.git && \
    cd ~/git/snowflake/ && \
    snowflakeCommitHash=$(git rev-parse --short HEAD) && \
    cd ~/git && \
    git clone https://gitlab.com/yawning/obfs4.git && \
    cd ~/git/obfs4 && \
    git fetch --tags && \
    obfs4LatestTag=$(git describe --tags "$(git rev-list --tags --max-count=1)") && \
    ubuntu_version=$(cat /etc/os-release | grep VERSION_ID | awk -F '"' '{print $2}') && \
    torLatestTag=$(echo $torLatestTag | sed 's/.*-//') && \
    obfs4LatestTag=$(echo $obfs4LatestTag | sed 's/.*-//') && \
    echo "ubuntu_rolling_${ubuntu_version}_tor_${torLatestTag}_obfs4proxy_${obfs4LatestTag}_webtunnel_${webtunnelCommitHash}_snowflake_${snowflakeCommitHash}" > /version.txt

CMD cat /version.txt