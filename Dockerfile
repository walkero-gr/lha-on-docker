# The ubuntu:latest tag points to the "latest LTS", since that's the version recommended for general use.
FROM ubuntu:latest

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /tmp

ENV PACKAGES="autoconf \
        automake \
        ca-certificates \
        git \
        libtool \
        make"

RUN apt-get update && apt-get -y --no-install-recommends install ${PACKAGES}; \
    git clone https://github.com/jca02266/lha.git && \
    mkdir build && \
    cd lha || exit && \
    autoreconf -vfi && \
    cd ../build && \
    ../lha/configure --prefix=/usr && \
    make && \
    make install; \
    apt-get -y remove ${PACKAGES}; \
    apt-get -y autoremove; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;