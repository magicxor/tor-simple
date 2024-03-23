FROM ubuntu:latest

ARG BUILD_PLATFORM
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

RUN apt-get update && \
    apt-get install -y curl tor tor-geoipdb obfs4proxy && \
    tor_version=$(apt-cache madison tor | awk '{print $3; exit}') && \
    obfs4proxy_version=$(apt-cache madison obfs4proxy | awk '{print $3; exit}') && \
    ubuntu_version=$(cat /etc/os-release | grep VERSION_ID | awk -F '"' '{print $2}') && \
    actualVersion="ubuntu_lts_${ubuntu_version}_tor_${tor_version}_obfs4proxy_${obfs4proxy_version}" && \
    if [ "$actualVersion" != "$VERSION" ]; then echo "Version mismatch: expected $VERSION, got $actualVersion" && exit 1; fi

EXPOSE 9050

HEALTHCHECK --interval=60s --timeout=15s --start-period=20s \
    CMD curl -s --socks5 127.0.0.1:9050 'https://check.torproject.org/' | grep -qm1 Congratulations

VOLUME ["/var/lib/tor"]
CMD ["tor"]
