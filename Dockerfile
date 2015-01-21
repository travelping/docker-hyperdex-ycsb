FROM ubuntu:14.04

MAINTAINER umatomba@gmail.com

USER root

RUN apt-get update
RUN apt-get install -y wget
RUN wget -O - http://ubuntu.hyperdex.org/hyperdex.gpg.key | apt-key add -
RUN echo "deb [arch=amd64] http://ubuntu.hyperdex.org trusty main" > /etc/apt/sources.list.d/hyperdex.list
RUN apt-get update
RUN apt-get install -y openjdk-6-jdk build-essential python2.7 python2.7-dev python-pyparsing python-setuptools python-argparse cython swig2.0 autoconf automake autoconf-archive libtool pkg-config gperf

RUN mkdir /hyperdex_build
WORKDIR /hyperdex_build
RUN wget https://google-glog.googlecode.com/files/glog-0.3.3.tar.gz
RUN tar xzf glog-0.3.3.tar.gz
WORKDIR /hyperdex_build/glog-0.3.3
RUN ./configure
RUN make
RUN make install

WORKDIR /hyperdex_build
RUN wget http://rpm5.org/files/popt/popt-1.16.tar.gz
RUN tar xzf popt-1.16.tar.gz
WORKDIR /hyperdex_build/popt-1.16
RUN ./configure
RUN make
RUN make install

ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/

WORKDIR /hyperdex_build
RUN wget http://hyperdex.org/src/libpo6-0.6.0.tar.gz
RUN tar xzf libpo6-0.6.0.tar.gz
WORKDIR /hyperdex_build/libpo6-0.6.0
RUN ./configure
RUN make
RUN make install

WORKDIR /hyperdex_build
RUN wget http://hyperdex.org/src/libe-0.9.0.tar.gz
RUN tar xzf libe-0.9.0.tar.gz
WORKDIR /hyperdex_build/libe-0.9.0
RUN ./configure
RUN make
RUN make install

WORKDIR /hyperdex_build
RUN wget http://hyperdex.org/src/busybee-0.5.2.tar.gz
RUN tar xzf busybee-0.5.2.tar.gz
WORKDIR /hyperdex_build/busybee-0.5.2
RUN ./configure
RUN make
RUN make install

WORKDIR /hyperdex_build
RUN wget http://hyperdex.org/src/hyperleveldb-1.2.2.tar.gz
RUN tar xzf hyperleveldb-1.2.2.tar.gz
WORKDIR /hyperdex_build/hyperleveldb-1.2.2
RUN ./configure
RUN make
RUN make install

WORKDIR /hyperdex_build
RUN wget http://hyperdex.org/src/replicant-0.6.4.tar.gz
RUN tar xzf replicant-0.6.4.tar.gz
WORKDIR /hyperdex_build/replicant-0.6.4
RUN ./configure
RUN make
RUN make install

WORKDIR /hyperdex_build
RUN wget http://hyperdex.org/src/libtreadstone-0.1.0.tar.gz
RUN tar xzf libtreadstone-0.1.0.tar.gz
WORKDIR /hyperdex_build/libtreadstone-0.1.0
RUN ./configure
RUN make
RUN make install

WORKDIR /hyperdex_build
RUN wget https://download.libsodium.org/libsodium/releases/libsodium-0.7.0.tar.gz
RUN tar xzf libsodium-0.7.0.tar.gz
WORKDIR /hyperdex_build/libsodium-0.7.0
RUN ./configure
RUN make
RUN make install

WORKDIR /hyperdex_build
RUN wget http://hyperdex.org/src/libmacaroons-0.2.0.tar.gz
RUN tar xzf libmacaroons-0.2.0.tar.gz
WORKDIR /hyperdex_build/libmacaroons-0.2.0
RUN ./configure
RUN make
RUN make install

WORKDIR /hyperdex_build
RUN wget http://hyperdex.org/src/hyperdex-1.6.0.tar.gz
RUN tar xzf hyperdex-1.6.0.tar.gz
WORKDIR /hyperdex_build/hyperdex-1.6.0
RUN ./configure --enable-java-bindings --enable-ycsb
RUN make
RUN make install

VOLUME /hyperdex_build

CMD /bin/bash
