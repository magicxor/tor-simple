FROM ubuntu:latest

ARG BUILD_PLATFORM
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

RUN apt-get update && \
    apt-get install -y curl tor obfs4proxy

EXPOSE 9050

HEALTHCHECK --interval=60s --timeout=15s --start-period=20s \
    CMD curl -s --socks5 127.0.0.1:9050 'https://check.torproject.org/' | grep -qm1 Congratulations

VOLUME ["/var/lib/tor"]
CMD ["tor"]
