FROM ubuntu:latest

RUN apt-get update && \
    tor_version=$(apt-cache madison tor | awk '{print $3; exit}') && \
    obfs4proxy_version=$(apt-cache madison obfs4proxy | awk '{print $3; exit}') && \
    ubuntu_version=$(cat /etc/os-release | grep VERSION_ID | awk -F '"' '{print $2}') && \
    echo "${ubuntu_version}_${tor_version}_${obfs4proxy_version}" > /version.txt

CMD cat /version.txt
