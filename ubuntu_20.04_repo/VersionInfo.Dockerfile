FROM ubuntu:20.04

RUN apt-get update && \
    tor_version=$(apt-cache madison tor | awk '{print $3; exit}') && \
    obfs4proxy_version=$(apt-cache madison obfs4proxy | awk '{print $3; exit}') && \
    ubuntu_version=$(cat /etc/os-release | grep VERSION_ID | awk -F '"' '{print $2}') && \
    echo "ubuntu_lts_${ubuntu_version}_tor_${tor_version}_obfs4proxy_${obfs4proxy_version}" > /version.txt

CMD cat /version.txt
